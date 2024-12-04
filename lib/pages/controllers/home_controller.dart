import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prototpye_glowguide/models/usermodel.dart';

class HomeController extends GetxController {
  var user = Rxn<UserModel>(); // Add a user variable to store the user data

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser != null) {
      try {
        // Fetch additional user info (username, birthdate, gender) from your custom users table
        final response = await Supabase.instance.client
            .from('users') // assuming you have a 'users' table
            .select('id, username, email, created_at, birth_date, gender')
            .eq('id', currentUser.id) // Use the user id to fetch their data
            .single(); // Fetch a single row

        // Create a User object
        user.value = UserModel.fromJson(response);
      } catch (e) {
        print('Failed to fetch user data: $e');
      }
    }
  }
}