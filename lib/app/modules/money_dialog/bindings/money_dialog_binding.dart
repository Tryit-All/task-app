import 'package:get/get.dart';

import '../controllers/money_dialog_controller.dart';

class MoneyDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoneyDialogController>(
      () => MoneyDialogController(),
    );
  }
}
