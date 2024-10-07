import 'package:get/get.dart';

import '../controllers/new_recurring_task_controller.dart';

class NewRecurringTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewRecurringTaskController>(
      () => NewRecurringTaskController(),
    );
  }
}
