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
            const SizedBox(height: 10),
            // Face Problem Section
            const Text(
              'Face Problem',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
