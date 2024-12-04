import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prototpye_glowguide/models/usermodel.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var rememberMe = false.obs;
  var isLoading = false.obs;
  var user = Rxn<UserModel>(); // Add a user variable to store the logged-in user

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

      // Fetch additional user info (birthdate, gender) from your custom users table
      final userResponse = await Supabase.instance.client
          .from('users') // assuming you have a 'users' table
          .select('id, username, email, created_at, birth_date, gender')
          .eq('id', response.user!.id) // Use the user id to fetch their data
          .single(); // Fetch a single row

      // Create a User object
      user.value = UserModel.fromJson(userResponse);

      // You can now use the `user` object as needed

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