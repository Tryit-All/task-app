import 'package:get/get.dart';

import '../controllers/clock_dialog_controller.dart';

class ClockDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClockDialogController>(
      () => ClockDialogController(),
    );
  }
}
