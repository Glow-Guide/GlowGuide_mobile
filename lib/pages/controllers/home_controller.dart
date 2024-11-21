import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  var username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('users').select('username');

    if (response.isNotEmpty) {
      username.value = response[0]['username'] as String? ?? '';
    }
  }
}
