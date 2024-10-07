import 'package:get/get.dart';

import '../controllers/all_team_controller.dart';

class AllTeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllTeamController>(
      () => AllTeamController(),
    );
  }
}
