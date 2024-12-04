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
      final url = 'https://wgxz3g9l-5000.asse.devtunnels.ms/upload';

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
        predictionFeatures.value = parseFeatures(data['feature']);
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

 Map<String, dynamic> parseFeatures(String featureString) {
  final featureList = featureString
      .replaceAll('[', '')
      .replaceAll(']', '')
      .split(RegExp(r'\s+'))
      .where((element) => element.isNotEmpty)
      .map((e) {
        try {
          return double.parse(e);
        } catch (error) {
          debugPrint('Error parsing feature value: $e');
          return 0.0; 
        }
      })
      .toList();

  final featureNames = [
    'mean_L', 'var_L', 'mean_a', 'var_a', 'mean_b', 'var_b', 'mean_H', 'var_H',
    'mean_S', 'var_S', 'mean_V', 'var_V', 'mean_Cb', 'var_Cb', 'mean_Cr', 'var_Cr',
    'mean_RI', 'var_RI', 'LBP_bin_0', 'LBP_bin_1', 'LBP_bin_2', 'LBP_bin_3',
    'LBP_bin_4', 'LBP_bin_5', 'LBP_bin_6', 'LBP_bin_7', 'LBP_bin_8', 'LBP_bin_9',
    'LBP_bin_10', 'LBP_bin_11', 'LBP_bin_12', 'LBP_bin_13', 'LBP_bin_14', 'LBP_bin_15',
    'LBP_bin_16', 'LBP_bin_17', 'LBP_bin_18', 'LBP_bin_19', 'LBP_bin_20', 'LBP_bin_21',
    'LBP_bin_22', 'LBP_bin_23', 'LBP_bin_24', 'LBP_bin_25', 'edge_density', 'num_contours',
    'mean_contour_area', 'std_contour_area'
  ];

  final featureMap = <String, dynamic>{};
  for (int i = 0; i < featureNames.length; i++) {
    featureMap[featureNames[i]] = featureList.length > i ? featureList[i] : 0.0;
  }

  return featureMap;
}
}