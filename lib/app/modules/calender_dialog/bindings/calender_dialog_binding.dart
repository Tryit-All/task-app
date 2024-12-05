import 'package:get/get.dart';

import '../controllers/calender_dialog_controller.dart';

class CalenderDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalenderDialogController>(
      () => CalenderDialogController(),
    );
  }
}
