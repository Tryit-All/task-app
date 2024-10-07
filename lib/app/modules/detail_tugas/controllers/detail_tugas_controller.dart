import 'package:get/get.dart';
import 'package:task_app/app/data/model/task_model.dart';

class DetailTugasController extends GetxController {
  //TODO: Implement DetailTugasController

  final count = 0.obs;
  var tasks = <TaskModel>[].obs;
  var progress = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    tasks.addAll([
      TaskModel('Tugas 1', 'Membuat moodboard'),
      TaskModel('Tugas 2', 'Membuat wireframe'),
      TaskModel('Tugas 3', 'Membuat komponen desain'),
      TaskModel('Tugas 4', 'Meeting dengan klien'),
      TaskModel('Tugas 5', 'Membuat desain'),
    ]);
    calculateProgress();
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
  void toggleTaskCompletion(int index) {
    tasks[index].isTogled.value = !tasks[index].isTogled.value;
    calculateProgress();
  }

  void calculateProgress() {
    int completedTasks = tasks.where((task) => task.isTogled.value).length;
    progress.value = completedTasks / tasks.length;
  }
}
