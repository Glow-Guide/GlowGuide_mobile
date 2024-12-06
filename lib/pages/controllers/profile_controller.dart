import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  var username = 'User'.obs;
  var email = ''.obs;
  var createdAt = ''.obs;
  var birthdate = ''.obs;
  var gender = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  // Fetch profile data from Supabase
  void fetchProfileData() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      try {
        // Fetch username, email, and created_at from Supabase Auth
        username.value = user.userMetadata?['username'] ?? 'User';
        email.value = user.email ?? '';
        createdAt.value =
            user.createdAt != null ? user.createdAt.toString() : '';

        // Fetch additional user info (birthdate, gender) from your custom users table
        final response = await Supabase.instance.client
            .from('users') // assuming you have a 'users' table
            .select('birth_date, gender')
            .eq('id', user.id) // Use the user id to fetch their data
            .single(); // Fetch a single row

        // Directly update birthdate and gender values if data is available
        birthdate.value = response['birth_date'] ?? '';
        gender.value = response['gender'] ?? '';
      } catch (e) {
        print(e);
        // Catch any error that occurs during the fetch operation
        Get.snackbar(
          'Error',
          'Failed to fetch additional user data: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  // Navigate to profile edit page
  void editProfile() {
    Get.toNamed('/register');
  }

  // Sign out the user 
  Future<void> signOut() async {
    try {
      await Supabase.instance.client.auth.signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign out. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
