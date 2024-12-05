import 'package:get/get.dart';

import '../controllers/goals_detail_controller.dart';

class GoalsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoalsDetailController>(
      () => GoalsDetailController(),
    );
  }
}
