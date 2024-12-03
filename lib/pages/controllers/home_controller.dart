import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  var username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsername();
  }

   void fetchUsername() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      username.value = user.userMetadata?['username'] ?? 'User';
    }
  }
}
