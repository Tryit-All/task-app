import 'package:get/get.dart';

import '../controllers/proyek_baru_controller.dart';

class ProyekBaruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProyekBaruController>(
      () => ProyekBaruController(),
    );
  }
}
