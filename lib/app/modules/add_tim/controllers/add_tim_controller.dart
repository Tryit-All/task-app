import 'package:get/get.dart';
import 'package:task_app/app/data/model/member_model.dart';

class AddTimController extends GetxController {
  //TODO: Implement AddTimController

  final count = 0.obs;
  var member = <Member>[].obs;
  var progress = 0.obs;

  @override
  void onInit() {
    super.onInit();
    member.addAll([
      Member(
          'Amy Vis', 'Admin', 'https://randomuser.me/api/portraits/men/70.jpg'),
      Member('M Daffa', 'Manager',
          'https://randomuser.me/api/portraits/men/72.jpg'),
      Member('Fikri Maulana', 'Admin',
          'https://randomuser.me/api/portraits/men/71.jpg'),
      Member('Jean Gunnhildr', '',
          'https://randomuser.me/api/portraits/men/73.jpg'),
      Member(
          'Ciko Saputra', '', 'https://randomuser.me/api/portraits/men/74.jpg'),
      Member(
          'Achmad Faris', '', 'https://randomuser.me/api/portraits/men/75.jpg'),
      Member('Huanfarey', '', 'https://randomuser.me/api/portraits/men/76.jpg'),
      Member('S Tina', '', 'https://randomuser.me/api/portraits/men/77.jpg'),
      Member(
          'Ananda Fer', '', 'https://randomuser.me/api/portraits/men/78.jpg'),
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

  void toggleTaskCompletion(int index) {
    member[index].isCompleted.value = !member[index].isCompleted.value;
    calculateProgress();
  }

  void calculateProgress() {
    int completedTasks =
        member.where((member) => member.isCompleted.value).length;
    progress.value = completedTasks;
  }

  void increment() => count.value++;
}
