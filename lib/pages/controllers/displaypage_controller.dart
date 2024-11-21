import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototpye_glowguide/pages/views/faceanalysispage_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DisplayPictureController extends GetxController {
  final String imagePath;
  final SupabaseClient supabase = Supabase.instance.client;

  DisplayPictureController({required this.imagePath});

  Future<void> uploadPicture() async {
    try {
      final response = await supabase.from('users').select('username');
      final file = File(imagePath);
      final username = response[0]['username'] as String;

      // Upload picture to Supabase storage
      final String fullPath = await supabase.storage.from('images').upload(
        'images/${username}_${DateTime.now().toString().replaceAll(RegExp(r"[:\-\. ]"), "")}.jpg',
        file,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

      // Navigate to FaceAnalysisPage after successful upload
      Get.to(() => FaceAnalysisPage(imagePath: imagePath));
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
