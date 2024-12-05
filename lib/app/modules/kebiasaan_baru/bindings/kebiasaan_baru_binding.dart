import 'package:get/get.dart';

import '../controllers/kebiasaan_baru_controller.dart';

class KebiasaanBaruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KebiasaanBaruController>(
      () => KebiasaanBaruController(),
    );
  }
}
