import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/faceanalysis_controller.dart';

class FaceAnalysisPage extends StatelessWidget {
  final String imagePath;

  const FaceAnalysisPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    // Bind the controller to this view
    final controller = Get.put(FaceAnalysisController(imagePath: imagePath));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Analysis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the selected image
            Image.file(
              File(imagePath),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            // Face Diagnosis Section
            const Text(
              'Face Diagnosis',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Prediction: ${controller.predictionLabel.value}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Confidence: ${(double.parse(controller.predictionConfidence.value) * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return controller.predictionLabel.isEmpty
                  ? const CircularProgressIndicator() // Show loading spinner while fetching results
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            ExpansionTile(
                              title: const Text(
                                'Extracted Features',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              children: controller.predictionFeatures.entries
                                  .map((entry) {
                                return ListTile(
                                  title: Text('${entry.key}: ${entry.value}'),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
