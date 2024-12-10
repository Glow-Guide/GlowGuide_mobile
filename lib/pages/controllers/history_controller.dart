import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HistoryController extends GetxController {
  var results = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchResults();
  }

  Future<void> fetchResults() async {
    try {
      isLoading.value = true;

      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      final response = await Supabase.instance.client
          .from('scanresult')
          .select('*')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

   

      results.value = response.toList();
    } catch (e) {
      Get.snackbar(
        'Fetch Failed',
        'Could not load history: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
