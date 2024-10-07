import 'package:get/get.dart';
import 'package:task_app/app/data/model/member_model.dart';

class AllTeamController extends GetxController {
  //TODO: Implement AllTeamController

  final count = 0.obs;
  final selectFilter = false.obs;
  var member = <Member>[].obs;
  @override
  void onInit() {
    super.onInit();
    member.addAll([
      Member(
          'Amy Vis', 'Admin', 'https://randomuser.me/api/portraits/men/70.jpg'),
    ]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
