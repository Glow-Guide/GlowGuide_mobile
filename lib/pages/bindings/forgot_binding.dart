import 'package:get/get.dart';

import 'package:prototpye_glowguide/pages/controllers/forgotpassword_controller.dart';

class ForgotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(),
    );
  }
}
