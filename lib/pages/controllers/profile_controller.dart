import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prototpye_glowguide/models/usermodel.dart';

class ProfileController extends GetxController {
  var user = UserModel(
    id: '',
    username: 'User',
    email: '',
    createdAt: '',
    birthdate: '',
    gender: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  // Fetch profile data from Supabase
  void fetchProfileData() async {
    final currentUser = Supabase.instance.client.auth.currentUser;

    if (currentUser != null) {
      try {
        // Fetch additional user info (birthdate, gender) from your custom users table
        final response = await Supabase.instance.client
            .from('users') // assuming you have a 'users' table
            .select('id, username, email, created_at, birth_date, gender')
            .eq('id', currentUser.id) // Use the user id to fetch their data
            .single(); // Fetch a single row

        // Update the user object
        user.value = UserModel.fromJson(response);
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