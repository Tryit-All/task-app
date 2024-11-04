import 'package:get/get.dart';

import '../controllers/detail_reminder_controller.dart';

class DetailReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailReminderController>(
      () => DetailReminderController(),
    );
  }
}
