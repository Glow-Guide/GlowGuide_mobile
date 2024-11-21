import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototpye_glowguide/pages/controllers/displaypage_controller.dart';

class DisplayPicturePage extends StatelessWidget {
  final String imagePath;

  const DisplayPicturePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisplayPictureController(imagePath: imagePath));

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Image.file(File(imagePath)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Go back to the camera page.
                },
                child: const Text('Retake Picture'),
              ),
              ElevatedButton(
                onPressed: () => controller.uploadPicture(),
                child: const Text('Save Picture'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
