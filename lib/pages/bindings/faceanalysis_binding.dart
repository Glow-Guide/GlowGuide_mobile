import 'package:get/get.dart';

import 'package:prototpye_glowguide/pages/controllers/faceanalysis_controller.dart';

class FaceanalysisBinding extends Bindings {
    final String imagePath;
      FaceanalysisBinding({required this.imagePath});


  @override
  void dependencies() {
    Get.lazyPut<FaceAnalysisController>(
      () => FaceAnalysisController(imagePath: imagePath),
    );
  }
}
