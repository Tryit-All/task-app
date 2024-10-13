import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/data/model/model_gantt_chart.dart';
import 'package:intl/intl.dart';
import '../controllers/gantt_chart_controller.dart';

class GanttChartView extends GetView<GanttChartController> {
  GanttChartView({Key? key}) : super(key: key);

  GanttChartController ganttChartController = Get.put(GanttChartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Project Timeline')),
      body: Obx(() => _buildTimeline()),
    );
  }

  Widget _buildTimeline() {
    final startDate = controller.getEarliestStartDate();
    final endDate = controller.getLatestEndDate();
    final totalDays = endDate.difference(startDate).inDays + 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(startDate, totalDays),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: controller.tasks
                  .map((task) => _buildTaskRow(task, startDate, totalDays))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(DateTime startDate, int totalDays) {
    return Row(
      children: [
        _buildHeaderCell('Task Name', 180),
        _buildHeaderCell('Start Date', 100),
        _buildHeaderCell('End Date', 100),
        Row(
          children: List.generate(
            totalDays,
            (index) => Container(
              width: 80,
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Text(
                DateFormat('E, d').format(startDate.add(Duration(days: index))),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String text, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTaskRow(ProjectTask task, DateTime startDate, int totalDays) {
    return Obx(() {
      final taskStart = task.startDate.value.difference(startDate).inDays;
      final taskDuration =
          task.endDate.value.difference(task.startDate.value).inDays + 1;
      final isSelected = controller.selectedTask.value == task;

      return GestureDetector(
        onTap: () => controller.selectTask(controller.tasks.indexOf(task)),
        child: Container(
          decoration: BoxDecoration(
              color: isSelected ? AppColors.quinaryColor : Colors.white,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Container(
                width: 180,
                padding: EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Obx(() => Text(
                    "${task.name}: ${(task.progress.value * 100).toStringAsFixed(0)}%")),
              ),
              Container(
                width: 100,
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child:
                    Text(DateFormat('yyyy-MM-dd').format(task.startDate.value)),
              ),
              Container(
                width: 100,
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child:
                    Text(DateFormat('yyyy-MM-dd').format(task.endDate.value)),
              ),
              Stack(
                children: [
                  CustomPaint(
                    size: Size(totalDays * controller.cellWidth, 40),
                    painter: TaskRowPainter(
                      taskStart: taskStart,
                      taskDuration: taskDuration,
                      totalDays: totalDays,
                      taskColor: task.color,
                      cellWidth: controller.cellWidth,
                      paddingTop: 2,
                      paddingBottom: 2,
                      progress: task.progress.value,
                    ),
                  ),
                  Positioned(
                    left: taskStart * controller.cellWidth,
                    top: 0,
                    bottom: 0,
                    width: taskDuration * controller.cellWidth,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        controller.moveEntireTask(task, details.delta.dx);
                      },
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Positioned(
                    left: taskStart * controller.cellWidth + 5,
                    top: 5,
                    bottom: 5,
                    child: _buildResizeHandle(
                      isLeft: true,
                      isSelected: isSelected,
                      onDragUpdate: (dx) =>
                          controller.updateTaskStartDate(task, dx),
                    ),
                  ),
                  Positioned(
                    left:
                        (taskStart + taskDuration) * controller.cellWidth - 15,
                    top: 5,
                    bottom: 5,
                    child: _buildResizeHandle(
                      isLeft: false,
                      isSelected: isSelected,
                      onDragUpdate: (dx) {
                        controller.updateTaskEndDate(task, dx);
                      },
                    ),
                  ),
                  Positioned(
                    left: (taskStart * controller.cellWidth) + 25,
                    top: 10,
                    child: Text(
                      "${task.name}: ${(task.progress.value * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (isSelected)
                    Positioned(
                      bottom: 0,
                      left: taskStart * controller.cellWidth +
                          (taskDuration *
                              controller.cellWidth *
                              task.progress.value),
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          double newProgress = (details.localPosition.dx -
                                  taskStart * controller.cellWidth) /
                              (taskDuration * controller.cellWidth);
                          controller.updateTaskProgress(task, newProgress);
                        },
                        child: CustomPaint(
                          size: Size(10, 10),
                          painter: TrianglePainter(),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildResizeHandle({
    required bool isLeft,
    required bool isSelected,
    required Function(double) onDragUpdate,
  }) {
    return GestureDetector(
      onHorizontalDragStart: (_) {
        print('Started dragging ${isLeft ? "left" : "right"} handle');
      },
      onHorizontalDragUpdate: (details) {
        print(
            'Dragging ${isLeft ? "left" : "right"} handle: ${details.delta.dx}');

        onDragUpdate(
            details.delta.dx); // Use delta.dx instead of localPosition.dx
      },
      onHorizontalDragEnd: (_) {
        print('Ended dragging ${isLeft ? "left" : "right"} handle');
      },
      child: Container(
        width: 10,
        height: double.infinity,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 150, 106, 160)
              : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(
          child: Container(
            width: 3,
            height: 20,
            color: isSelected
                ? const Color.fromARGB(255, 150, 106, 160)
                : Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class TaskRowPainter extends CustomPainter {
  final int taskStart;
  final int taskDuration;
  final int totalDays;
  final Color taskColor;
  final double cellWidth;
  final double paddingTop;
  final double paddingBottom;
  final double progress;

  TaskRowPainter({
    required this.taskStart,
    required this.taskDuration,
    required this.totalDays,
    required this.taskColor,
    required this.cellWidth,
    this.paddingTop = 5.0,
    this.paddingBottom = 5.0,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey;

    // Draw grid lines
    for (int i = 0; i <= totalDays; i++) {
      final x = i * cellWidth;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint..color = Colors.grey.withOpacity(0.5),
      );
    }

    // Calculate height with padding
    final taskHeight = size.height - paddingTop - paddingBottom;

    // Calculate task width
    final taskWidth = taskDuration * cellWidth;

    // Draw task background with rounded corners and padding
    final taskRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        taskStart * cellWidth, // x-position
        paddingTop, // y-position adjusted with padding
        taskWidth, // width
        taskHeight, // height adjusted with padding
      ),
      Radius.circular(8), // Set corner radius to 8
    );
    canvas.drawRRect(
      taskRect,
      paint..color = taskColor.withOpacity(0.5),
    );

    // Draw task border with rounded corners and padding
    canvas.drawRRect(
      taskRect,
      paint
        ..color = taskColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Calculate progress width based on task width
    final progressWidth = taskWidth * progress;

    // Draw progress bar
    final progressRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        taskStart * cellWidth, // Start from the left handle
        paddingTop,
        progressWidth, // Width based on progress
        taskHeight,
      ),
      Radius.circular(8),
    );
    canvas.drawRRect(
        progressRect,
        paint
          ..color = AppColors.trinaryColor
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant TaskRowPainter oldDelegate) {
    return oldDelegate.taskStart != taskStart ||
        oldDelegate.taskDuration != taskDuration ||
        oldDelegate.totalDays != totalDays ||
        oldDelegate.taskColor != taskColor ||
        oldDelegate.cellWidth != cellWidth ||
        oldDelegate.paddingTop != paddingTop ||
        oldDelegate.paddingBottom != paddingBottom;
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.quaternaryColor
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
