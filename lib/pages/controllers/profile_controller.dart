import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  var username = 'User'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsername();
  }

  // Fetch username from Supabase
  void fetchUsername() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      username.value = user.userMetadata?['username'] ?? 'User';
    }
  }

  // Navigate to profile edit page
  void editProfile() {
    Get.toNamed('/editProfile');
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
