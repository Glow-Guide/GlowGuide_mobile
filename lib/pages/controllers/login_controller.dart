import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var rememberMe = false.obs;
  var isLoading = false.obs;

  // Show Lottie success animation
  void showSuccessAnimation() {
    Get.dialog(
      Center(
        child: Lottie.asset(
          'lib/assets/check.json',
          repeat: false,
          onLoaded: (composition) {
            Future.delayed(composition.duration, () {
              Get.back(); // Close the dialog after animation finishes
              Get.offAllNamed('/home'); // Navigate to home
            });
          },
        ),
      ),
      barrierDismissible: false,
    );
  }

  // Login method
  Future<void> login() async {
    isLoading.value = true;

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response.session == null || response.user == null) {
        throw Exception('Login failed');
      }

      // Show success animation
      showSuccessAnimation();
    } catch (e) {
      Get.snackbar(
        'Login failed with error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
