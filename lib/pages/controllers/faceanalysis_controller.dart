import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FaceAnalysisController extends GetxController {
  final String imagePath;

  // Observable variables for prediction results
  var predictionLabel = ''.obs;
  var predictionConfidence = ''.obs;
  var predictionFeatures = <String, dynamic>{}.obs;

  FaceAnalysisController({required this.imagePath});

  @override
  void onInit() {
    super.onInit();
    getPrediction(); // Fetch prediction when the controller is initialized
  }

  Future<void> getPrediction() async {
    try {
    final url = 'https://glow-guide.evenify.my.id/upload';

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

}