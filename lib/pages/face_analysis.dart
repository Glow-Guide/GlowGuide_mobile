import 'dart:io';
import 'package:flutter/material.dart';

class FaceAnalysisPage extends StatelessWidget {
  final String imagePath; // Path to the selected image

  // Constructor to accept the image path
  FaceAnalysisPage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Analysis'),
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
            // Text for Face Diagnosis
            const Text(
              'Face Diagnosis',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Text for Face Problem
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
