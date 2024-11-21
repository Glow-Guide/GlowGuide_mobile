import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // Email text field controller
  final emailController = TextEditingController();

  // Function to handle password reset email sending
  void sendPasswordResetEmail() {
    Get.dialog(
      AlertDialog(
        title: const Text('Email Sent'),
        content: const Text(
          'A password reset link has been sent to your email.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              Get.offAllNamed('/login'); // Navigate to the login page
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
