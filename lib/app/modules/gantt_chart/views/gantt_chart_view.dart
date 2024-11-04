import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/data/model/model_gantt_chart.dart';
import 'package:intl/intl.dart';
import 'package:task_app/app/data/utils/custom_progress_slider.dart';
import '../controllers/gantt_chart_controller.dart';

class GanttChartView extends GetView<GanttChartController> {
  GanttChartView({Key? key}) : super(key: key);

  GanttChartController ganttChartController = Get.put(GanttChartController());

  void _updateParentTask(ProjectTask parentTask) {
    if (parentTask.subtasks.isNotEmpty) {
      // Calculate average progress from subtasks
      double totalProgress = 0;
      for (var subtask in parentTask.subtasks) {
        totalProgress += subtask.progress.value;
      }
      parentTask.progress.value = totalProgress / parentTask.subtasks.length;

      // Update parent's dates based on subtasks
      DateTime earliestStart = parentTask.subtasks
          .map((subtask) => subtask.startDate.value)
          .reduce((a, b) => a.isBefore(b) ? a : b);
      DateTime latestEnd = parentTask.subtasks
          .map((subtask) => subtask.endDate.value)
          .reduce((a, b) => a.isAfter(b) ? a : b);

      parentTask.startDate.value = earliestStart;
      parentTask.endDate.value = latestEnd;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Timeline'),
        actions: [
          _buildViewModeSelector(),
        ],
      ),
      body: Obx(() => _buildTimeline()),
    );
  }

  Widget _buildViewModeSelector() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() => CupertinoSlidingSegmentedControl<GanttViewMode>(
              onValueChanged: (GanttViewMode? newValue) {
                if (newValue != null) {
                  controller.changeViewMode(newValue);
                }
              },
              groupValue: controller.currentViewMode.value,
              padding: const EdgeInsets.all(4.0),
              children: {
                GanttViewMode.daily: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.calendar_view_day, size: 16),
                      SizedBox(width: 4),
                      Text('Daily'),
                    ],
                  ),
                ),
                GanttViewMode.weekly: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.calendar_view_week, size: 16),
                      SizedBox(width: 4),
                      Text('Weekly'),
                    ],
                  ),
                ),
                GanttViewMode.monthly: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.calendar_view_month, size: 16),
                      SizedBox(width: 4),
                      Text('Monthly'),
                    ],
                  ),
                ),
              },
            )));
  }

  String _formatHeaderDate(DateTime date) {
    switch (controller.currentViewMode.value) {
      case GanttViewMode.daily:
        return DateFormat('E, d MMM').format(date);
      case GanttViewMode.weekly:
        final endOfWeek = controller.getUnitEnd(date);
        return '${DateFormat('MMM d').format(date)} - ${DateFormat('MMM d').format(endOfWeek)}';
      case GanttViewMode.monthly:
        return DateFormat('MMMM yyyy').format(date);
    }
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

  Widget _buildHeader(DateTime startDate, int totalUnits) {
    return Row(
      children: [
        _buildHeaderCell('Task Name', 227),
        _buildHeaderCell('Start Date', 100),
        _buildHeaderCell('End Date', 100),
        Row(
          children: List.generate(
            totalUnits,
            (index) {
              DateTime currentDate;
              switch (controller.currentViewMode.value) {
                case GanttViewMode.daily:
                  currentDate = startDate.add(Duration(days: index));
                  break;
                case GanttViewMode.weekly:
                  currentDate = startDate.add(Duration(days: index * 7));
                  break;
                case GanttViewMode.monthly:
                  currentDate =
                      DateTime(startDate.year, startDate.month + index);
                  break;
              }
              return Container(
                width: controller.cellWidthNew,
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 1,
                      color: Colors.transparent,
                      height: 18,
                    ),
                    Text(
                      _formatHeaderDate(currentDate),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 1,
                      color: Colors.grey,
                      height: 18,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String text, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 1,
            color: Colors.transparent,
            height: 18,
          ),
          Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: 1,
            color: Colors.grey,
            height: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskRow(ProjectTask task, DateTime startDate, int totalDays) {
    return Obx(() {
      final taskStart = task.startDate.value.difference(startDate).inDays;
      final taskDuration =
          task.endDate.value.difference(task.startDate.value).inDays + 1;
      final isSelected = controller.selectedTask.value == task;

      if (task.parent != null && !task.parent!.isExpanded.value) {
        return SizedBox.shrink(); // Hide this row
      }

      return GestureDetector(
        onTap: () => controller.selectTask(controller.tasks.indexOf(task)),
        child: Container(
          decoration: BoxDecoration(
              color: isSelected ? AppColors.quinaryColor : Colors.white,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              if (task.isParent && task.subtasks.isNotEmpty)
                Container(
                  width: 227,
                  padding: EdgeInsets.all(0),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 1,
                        color: Colors.grey,
                        height: 36,
                      ),
                      SizedBox(width: 13),
                      GestureDetector(
                        child: Icon(
                          task.isExpanded.value
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right,
                          size: 20,
                        ),
                        onTap: () {
                          task.isExpanded.value = !task.isExpanded.value;
                        },
                      ),
                      SizedBox(width: 14),
                      Text("${task.name}"),
                    ],
                  ),
                )
              else
                Container(
                  width: 227,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 1,
                        color: Colors.grey,
                        height: 36,
                      ),
                      Container(
                        child: Container(
                          child: Text("${task.name}"),
                        ),
                      ),
                      Container(
                        width: 1,
                        color: Colors.transparent,
                        height: 36,
                      ),
                    ],
                  ),
                ),
              Container(
                width: 100,
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 1,
                      color: Colors.grey,
                      height: 18,
                    ),
                    Text(DateFormat('yyyy-MM-dd').format(task.startDate.value)),
                    Container(
                      width: 1,
                      color: Colors.transparent,
                      height: 18,
                    ),
                  ],
                ),
              ),
              Container(
                width: 100,
                padding: EdgeInsets.all(0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 1,
                      color: Colors.grey,
                      height: 18,
                    ),
                    Text(DateFormat('yyyy-MM-dd').format(task.endDate.value)),
                    Container(
                      width: 1,
                      color: Colors.grey,
                      height: 36,
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  CustomPaint(
                    size: Size(totalDays * controller.cellWidthNew, 40),
                    painter: TaskRowPainter(
                      taskStart: taskStart,
                      taskDuration: taskDuration,
                      totalDays: totalDays,
                      taskColor: task.color,
                      cellWidth: controller.cellWidthNew,
                      paddingTop: 2,
                      paddingBottom: 2,
                      progress: task.progress.value,
                      viewMode:
                          controller.currentViewMode.value, // Add this line
                    ),
                  ),
                  if (!task.isParent) ...[
                    if (isSelected) ...[
                      Positioned(
                        left: controller
                            .getTaskStartPosition(taskStart.toDouble()),
                        top: 0,
                        bottom: 0,
                        width: controller.getTaskWidth(
                            taskStart.toDouble(), taskDuration.toDouble()),
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
                        left: controller
                            .getTaskStartPosition(taskStart.toDouble()),
                        top: 0,
                        bottom: 30,
                        width: controller.getTaskWidth(
                            taskStart.toDouble(), taskDuration.toDouble()),
                        child: GestureDetector(
                          onLongPress: () {
                            // Show tooltip on long press
                            ganttChartController.tooltipController
                                .showTooltip();
                            print("object");
                          },
                          onLongPressEnd: (details) {
                            ganttChartController.tooltipController
                                .hideTooltip();
                          },
                          child: MouseRegion(
                            child: SuperTooltip(
                              controller:
                                  ganttChartController.tooltipController,
                              showOnTap: false, // Don't show automatically
                              popupDirection: TooltipDirection.down,
                              showBarrier: true,
                              barrierColor: Colors.black54,
                              arrowLength: 10,
                              arrowBaseWidth: 10,
                              borderColor: Colors.grey.shade300,
                              borderWidth: 1,
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black54,
                              shadowBlurRadius: 10.0,
                              shadowSpreadRadius: 1.0,
                              content: Material(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  constraints: BoxConstraints(maxWidth: 200),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        task.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today,
                                              size: 14, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Text(
                                            'Start:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            DateFormat('yyyy-MM-dd')
                                                .format(task.startDate.value),
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today,
                                              size: 14, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Text(
                                            'End:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            DateFormat('yyyy-MM-dd')
                                                .format(task.endDate.value),
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.trending_up,
                                              size: 14, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Text(
                                            'Progress:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '${(task.progress.value * 100).toStringAsFixed(0)}%',
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.timeline,
                                              size: 14, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Text(
                                            'Duration:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '${task.endDate.value.difference(task.startDate.value).inDays + 1} days',
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: controller
                            .getTaskStartPosition(taskStart.toDouble()),
                        top: 28,
                        bottom: 0,
                        width: controller.getTaskWidth(
                            taskStart.toDouble(), taskDuration.toDouble()),
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 2,
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 5,
                              disabledThumbRadius: 2,
                            ),
                            overlayShape: RoundSliderOverlayShape(
                              overlayRadius: 15,
                            ),
                          ),
                          child: Slider(
                            value: task.progress.value,
                            divisions: 100,
                            thumbColor: AppColors.quaternaryColor,
                            activeColor: Colors.transparent,
                            inactiveColor: Colors.transparent,
                            min: 0,
                            max: 1,
                            onChanged: (value) {
                              task.progress.value = value;
                              if (task.parent != null) {
                                _updateParentTask(task.parent!);
                              }
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        left: controller
                                .getTaskStartPosition(taskStart.toDouble()) +
                            5,
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
                        left: controller
                                .getTaskStartPosition(taskStart.toDouble()) +
                            controller.getTaskWidth(
                                taskStart.toDouble(), taskDuration.toDouble()) -
                            15,
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
                    ],
                  ],
                  Positioned(
                      left: controller
                              .getTaskStartPosition(taskStart.toDouble()) +
                          25,
                      top: 10,
                      child: Obx(
                        () => Text(
                          "${task.name}: ${(task.progress.value * 100).toStringAsFixed(0)}%",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )),
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
              ? const Color.fromARGB(255, 150, 106, 170)
              : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(
          child: Container(
            width: 3,
            height: 20,
            color: isSelected
                ? const Color.fromARGB(255, 150, 106, 170)
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
  final GanttViewMode viewMode;

  TaskRowPainter({
    required this.taskStart,
    required this.taskDuration,
    required this.totalDays,
    required this.taskColor,
    required this.cellWidth,
    this.paddingTop = 5.0,
    this.paddingBottom = 5.0,
    required this.progress,
    required this.viewMode,
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

    // Calculate position and width based on view mode
    double startPosition;
    double barWidth;

    switch (viewMode) {
      case GanttViewMode.daily:
        startPosition = taskStart * cellWidth;
        barWidth = taskDuration * cellWidth;
        break;
      case GanttViewMode.weekly:
        startPosition = (taskStart / 7) * cellWidth;
        barWidth = (taskDuration / 7) * cellWidth;
        break;
      case GanttViewMode.monthly:
        // Assuming average month length of 30 days
        startPosition = (taskStart / 30) * cellWidth;
        barWidth = (taskDuration / 30) * cellWidth;
        break;
    }

    // Calculate height with padding
    final taskHeight = size.height - paddingTop - paddingBottom;

    // Draw task background with rounded corners and padding
    final taskRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        startPosition,
        paddingTop,
        barWidth,
        taskHeight,
      ),
      Radius.circular(8),
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
    final progressWidth = barWidth * progress;

    // Draw progress bar
    final progressRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        startPosition,
        paddingTop,
        progressWidth,
        taskHeight,
      ),
      Radius.circular(8),
    );
    canvas.drawRRect(
      progressRect,
      paint
        ..color = AppColors.trinaryColor
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant TaskRowPainter oldDelegate) {
    return oldDelegate.taskStart != taskStart ||
        oldDelegate.taskDuration != taskDuration ||
        oldDelegate.totalDays != totalDays ||
        oldDelegate.taskColor != taskColor ||
        oldDelegate.cellWidth != cellWidth ||
        oldDelegate.paddingTop != paddingTop ||
        oldDelegate.paddingBottom != paddingBottom ||
        oldDelegate.viewMode != viewMode;
  }
}
