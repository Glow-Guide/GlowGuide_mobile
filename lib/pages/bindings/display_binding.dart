import 'package:get/get.dart';
import 'package:prototpye_glowguide/pages/controllers/displaypage_controller.dart';

class DisplayBinding extends Bindings {
  final String imagePath;

  DisplayBinding({required this.imagePath});

  @override
  void dependencies() {
    Get.lazyPut<DisplayPictureController>(
      () => DisplayPictureController(imagePath: imagePath),
    );
  }
}