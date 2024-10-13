import 'package:get/get.dart';

import '../controllers/gantt_chart_controller.dart';

class GanttChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GanttChartController>(
      () => GanttChartController(),
    );
  }
}
