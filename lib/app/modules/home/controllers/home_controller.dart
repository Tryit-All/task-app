import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/model/task_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  var inner = 0.obs;
  var tasks = <Task>[].obs;
  late CarouselController carouselController;
  final List<String> tabs = ['Tim', 'Goals'];
  final RxInt selectedIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    carouselController = CarouselController();
    fetchTasks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onPageChanged(int index) {
    inner.value = index; // Memperbarui nilai inner secara reaktif
  }

  void fetchTasks() {
    var taskList = [
      Task("Tugas 1", "Mengerjakan Kuis", "07:00"),
      Task("Tugas 2", "Mempelajari Wireframe", "18:00"),
    ];

    tasks.assignAll(taskList);
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void toggleTaskCompletion(int index) {
    tasks[index].isCompleted.value = !tasks[index].isCompleted.value;
  }

  void increment() => count.value++;
}
