import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class FaceAnalysisController extends GetxController {
  final String imagePath;

  // Observable variables for prediction results
  var predictionLabel = ''.obs;
  var predictionConfidence = ''.obs;
  // var predictionFeatures = <String, dynamic>{}.obs;

  FaceAnalysisController({required this.imagePath});

  @override
  void onInit() {
    super.onInit();
    getPrediction(); // Fetch prediction when the controller is initialized
  }



  Future<void> getPrediction() async {
    try {
    final url = 'https://glowguidemachine-learning-production.up.railway.app/upload';
      // Read the file to send it in the POST request
      final file = File(imagePath);
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..files.add(await http.MultipartFile.fromPath('img', file.path));

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        predictionLabel.value = data['label'];
        predictionConfidence.value = data['confidence'];
      } else {
        throw Exception('Failed to get prediction: ${response.body}');
      }
    } catch (e) {
      Get.snackbar(
        'Prediction Failed',
        'Failed to analyze image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      debugPrint('Error in prediction: $e');
    }
  }

//UPLOAD IMAGE TO SUPABASE
Future<String> uploadImageToSupabase(String imagePath, String userId) async {
  final supabase = Supabase.instance.client;
  final file = File(imagePath);

  try {
    final fileName = 'images/${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final response = await supabase.storage
        .from('images')
        .upload(fileName, file);

   

    // Get the public URL of the uploaded image
    final publicUrl = supabase.storage.from('images').getPublicUrl(fileName);
    return publicUrl;
  } catch (e) {
    throw Exception('Error uploading image: $e');
  }
}
// SAVE SCAN RESULT TO SUPABASE

Future<void> saveResultToSupabase(String userId, String imageUrl, String label, String confidence) async {
  final supabase = Supabase.instance.client;

  try {
    final response = await supabase.from('scanresult').insert({
      'user_id': userId,
      'image_url': imageUrl,
      'prediction_label': label,
      'confidence': double.parse(confidence),
    });
  } catch (e) {
    throw Exception('Error saving result: $e');
  }
}

// RUN THE SAVE ANALYSIS RESULT FUNCTION
Future<void> saveAnalysisResult() async {
  try {
    // Fetch the current user ID (requires authentication setup in Supabase)
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not logged in');
    }

    // Upload the image to Supabase storage
    final imageUrl = await uploadImageToSupabase(imagePath, userId);

    // Save the prediction result in Supabase
    await saveResultToSupabase(
      userId,
      imageUrl,
      predictionLabel.value,
      predictionConfidence.value,
    );

    // Delete the image file from local storage
    final file = File(imagePath);
    if (await file.exists()) {
      await file.delete();
      debugPrint('Image deleted successfully');
    }

    // Show success message and navigate to home page
    Get.snackbar(
      'Success',
      'Result saved successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Navigate to the home page
    Get.offAllNamed('/home');
  } catch (e) {
    Get.snackbar(
      'Save Failed',
      'Failed to save analysis result: $e',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    debugPrint('Error saving analysis result: $e');
  }
}




}
