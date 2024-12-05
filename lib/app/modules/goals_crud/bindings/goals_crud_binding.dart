import 'package:get/get.dart';

import '../controllers/goals_crud_controller.dart';

class GoalsCrudBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoalsCrudController>(
      () => GoalsCrudController(),
    );
  }
}
