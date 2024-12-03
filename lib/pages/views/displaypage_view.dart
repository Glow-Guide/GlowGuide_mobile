import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototpye_glowguide/pages/controllers/displaypage_controller.dart';
import 'package:image_cropper/image_cropper.dart';

class DisplayPicturePage extends StatelessWidget {
  final String imagePath;

  const DisplayPicturePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisplayPictureController(imagePath: imagePath));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Display & Crop Picture'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return Image.file(
                File(controller.croppedImagePath.value.isNotEmpty
                    ? controller.croppedImagePath.value
                    : imagePath),
              );
            }),
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
                onPressed: () async {
                  await controller.cropImage(); // Crop the image before uploading.
                },
                child: const Text('Crop Image'),
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
