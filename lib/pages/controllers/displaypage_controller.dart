import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:prototpye_glowguide/pages/views/faceanalysispage_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DisplayPictureController extends GetxController {
  final String imagePath;
  final SupabaseClient supabase = Supabase.instance.client;

  // Use an observable for cropped image path
  var croppedImagePath = RxString('');

  DisplayPictureController({required this.imagePath});

  // Function to crop the image
  Future<void> cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        )
      ],
    );

    if (croppedFile != null) {
      croppedImagePath.value = croppedFile.path; // Set cropped image path
    }
  }

  // Function to upload the picture to Supabase
  Future<void> uploadPicture() async {
    try {
      final response = await supabase.from('users').select('username');
      final file = File(croppedImagePath.value.isNotEmpty
          ? croppedImagePath.value
          : imagePath); // Use cropped image if available
      final username = response[0]['username'] as String;

      // Upload picture to Supabase storage
      final String fullPath = await supabase.storage.from('images').upload(
            'images/${username}_${DateTime.now().toString().replaceAll(RegExp(r"[:\-\. ]"), "")}.jpg',
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      // Navigate to FaceAnalysisPage after successful upload
      Get.to(() => FaceAnalysisPage(imagePath: file.path));
    } catch (e) {
      Get.snackbar(
        'Upload Failed',
        'Failed to upload picture: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      debugPrint('Error uploading picture: $e');
    }
  }
}
