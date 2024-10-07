import 'package:get/get.dart';

import '../controllers/add_tim_controller.dart';

class AddTimBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTimController>(
      () => AddTimController(),
    );
  }
}
