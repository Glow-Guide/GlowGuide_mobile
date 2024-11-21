import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  var selectedGender = ''.obs;
  var isLoading = false.obs;

  void setSelectedGender(String? value) {
    if (value != null) {
      selectedGender.value = value;
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> register() async {
    isLoading.value = true;

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
        data: {
          'username': usernameController.text,
          'gender': selectedGender.value,
          'birth_date': birthDateController.text,
        },
      );

      if (response.user == null) {
        throw Exception('Registration failed');
      }

      // Save additional user information to Supabase
      final userId = response.user!.id;
      await Supabase.instance.client.from('users').insert({
        'id': userId,
        'email': emailController.text,
        'username': usernameController.text,
        'gender': selectedGender.value,
        'birth_date': birthDateController.text,
      });

      // Navigate to login page
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'An error occurred. Please try again.\n$e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
