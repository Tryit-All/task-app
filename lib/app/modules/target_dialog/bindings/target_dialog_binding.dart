import 'package:get/get.dart';

import '../controllers/target_dialog_controller.dart';

class TargetDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TargetDialogController>(
      () => TargetDialogController(),
    );
  }
}
