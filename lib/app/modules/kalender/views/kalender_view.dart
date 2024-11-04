import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/data/utils/basic_example.dart';
import 'package:task_app/app/data/utils/utils.dart';
import 'package:task_app/app/modules/gantt_chart/views/gantt_chart_view.dart';
import 'package:task_app/app/modules/reminder/views/reminder_view.dart';
import '../controllers/kalender_controller.dart';

class KalenderView extends GetView<KalenderController> {
  KalenderView({Key? key}) : super(key: key);
  final KalenderController controller = Get.put(KalenderController());
  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // NB: Uncomment to use any of the functions
            Get.to(() => GanttChartView());
            // Get.to(() => ReminderView());
          },
          backgroundColor: AppColors.primaryColor,
          child: Icon(
            Icons.waterfall_chart_rounded,
            color: Colors.white,
          )),
      body: Container(
        child: Column(
          children: [
            Obx(() => TableCalendar(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: controller.focusedDay.value,
                  selectedDayPredicate: (day) =>
                      isSameDay(controller.selectedDay.value, day),
                  rangeStartDay: controller.rangeStart.value,
                  rangeEndDay: controller.rangeEnd.value,
                  calendarFormat: controller.calendarFormat.value,
                  rangeSelectionMode: controller.rangeSelectionMode.value,
                  eventLoader: (day) => controller.getEventsForDay(day),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      return "${kEvents[day]}" == "null"
                          ? Container(
                              margin: const EdgeInsets.all(4.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                '${day.day}',
                                style: TextStyle(color: Colors.transparent),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
                              decoration: BoxDecoration(
                                color: kEvents[day]!.length == 1
                                    ? const Color.fromARGB(255, 222, 221, 253)
                                    : kEvents[day]!.length == 2
                                        ? const Color(0xFFC6E6FF)
                                        : const Color(0xFF80DCB0),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: Text(
                                '${kEvents[day]!.length} tugas',
                                style: TextStyle(
                                    fontSize: textScaleFactor <= 1.15 ? 8 : 4),
                              ),
                            );
                    },
                    todayBuilder: (context, day, focusedDay) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(13, 10, 13, 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.blue.shade200,
                        ),
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    selectedBuilder: (context, day, focusedDay) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(13, 10, 13, 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                          color: AppColors.primaryColor,
                        ),
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    // singleMarkerBuilder: (context, date, _) {
                    //   return Text(
                    //     '${kEvents[date]?.length ?? 0}',
                    //     style: const TextStyle(color: Colors.black),
                    //   );
                    // },
                  ),
                  onDaySelected: controller.onDaySelected,
                  onRangeSelected: controller.onRangeSelected,
                  onFormatChanged: controller.onFormatChanged,
                  onPageChanged: controller.onPageChanged,
                )),
            const SizedBox(height: 15.0),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.selectedEvents.length,
                    itemBuilder: (context, index) {
                      return Container(
                          color: Color(0xFFF9F7FF),
                          child: controller.selectedEvents[index].description !=
                                  ""
                              ? ListTile(
                                  onTap: () => print(
                                      '${controller.selectedEvents[index]}'),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Tugas ${controller.selectedEvents[index]} - ${controller.selectedEvents[index].description}'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: AppColors.trinaryColor),
                                          child: Text(
                                            '${controller.selectedEvents[index].time}',
                                            style: TextStyle(
                                                fontSize:
                                                    textScaleFactor <= 1.15
                                                        ? 13
                                                        : 9),
                                          )),
                                    ],
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Divider(
                                      color: Colors.grey.shade300,
                                      thickness: 1,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(17, 10, 17, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {},
                                            child: Text(
                                              textAlign: TextAlign.start,
                                              "Desain UI",
                                              style: TextStyle(
                                                  fontSize:
                                                      textScaleFactor <= 1.15
                                                          ? 16
                                                          : 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.setView();
                                            },
                                            child: Obx(() => controller
                                                        .powerOn.value ==
                                                    true
                                                ? Transform.rotate(
                                                    angle: math.pi / 2,
                                                    child: Icon(
                                                      Icons
                                                          .arrow_back_ios_rounded,
                                                      color: Colors.grey[400],
                                                    ))
                                                : Transform.rotate(
                                                    angle: -math.pi /
                                                        2, // Mengubah sudut rotasi ke arah yang benar
                                                    child: Icon(
                                                      Icons
                                                          .arrow_back_ios_rounded,
                                                      color: Colors.grey[400],
                                                    ),
                                                  )),
                                          )
                                        ],
                                      ),
                                      Obx(() => controller.powerOn.value == true
                                          ? Column(
                                              children: [
                                                Obx(
                                                  () => RadioListTile<int>(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    title:
                                                        const Text('Tiap hari'),
                                                    value: 0,
                                                    groupValue: controller
                                                        .selectedValue.value,
                                                    onChanged: (value) {
                                                      controller
                                                          .setSelectedValue(
                                                              value!);
                                                    },
                                                  ),
                                                ),
                                                Obx(
                                                  () => RadioListTile<int>(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    title: const Text(
                                                        'Hari tertentu dalam seminggu'),
                                                    value: 1,
                                                    groupValue: controller
                                                        .selectedValue.value,
                                                    onChanged: (value) {
                                                      controller
                                                          .setSelectedValue(
                                                              value!);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container()),
                                      Divider(
                                        color: Colors.grey.shade300,
                                      )
                                    ],
                                  ),
                                ));
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

// class TableEventsExample extends StatefulWidget {
//   @override
//   _TableEventsExampleState createState() => _TableEventsExampleState();
// }

// class _TableEventsExampleState extends State<TableEventsExample> {
//   late final ValueNotifier<List<Event>> _selectedEvents;
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
//       .toggledOff; // Can be toggled on/off by longpressing a date
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   DateTime? _rangeStart;
//   DateTime? _rangeEnd;

//   @override
//   void initState() {
//     super.initState();

//     _selectedDay = _focusedDay;
//     _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
//   }

//   @override
//   void dispose() {
//     _selectedEvents.dispose();
//     super.dispose();
//   }

//   List<Event> _getEventsForDay(DateTime day) {
//     // Implementation example
//     return kEvents[day] ?? [];
//   }

//   List<Event> _getEventsForRange(DateTime start, DateTime end) {
//     // Implementation example
//     final days = daysInRange(start, end);

//     return [
//       for (final d in days) ..._getEventsForDay(d),
//     ];
//   }

//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     if (!isSameDay(_selectedDay, selectedDay)) {
//       setState(() {
//         _selectedDay = selectedDay;
//         _focusedDay = focusedDay;
//         _rangeStart = null; // Important to clean those
//         _rangeEnd = null;
//         _rangeSelectionMode = RangeSelectionMode.toggledOff;
//       });

//       _selectedEvents.value = _getEventsForDay(selectedDay);
//     }
//   }

//   void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
//     setState(() {
//       _selectedDay = null;
//       _focusedDay = focusedDay;
//       _rangeStart = start;
//       _rangeEnd = end;
//       _rangeSelectionMode = RangeSelectionMode.toggledOn;
//     });

//     // `start` or `end` could be null
//     if (start != null && end != null) {
//       _selectedEvents.value = _getEventsForRange(start, end);
//     } else if (start != null) {
//       _selectedEvents.value = _getEventsForDay(start);
//     } else if (end != null) {
//       _selectedEvents.value = _getEventsForDay(end);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TableCalendar - Events'),
//       ),
//       body: Column(
//         children: [
//           TableCalendar<Event>(
//             firstDay: kFirstDay,
//             lastDay: kLastDay,
//             focusedDay: _focusedDay,
//             selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//             rangeStartDay: _rangeStart,
//             rangeEndDay: _rangeEnd,
//             calendarFormat: _calendarFormat,
//             rangeSelectionMode: _rangeSelectionMode,
//             eventLoader: _getEventsForDay,
//             startingDayOfWeek: StartingDayOfWeek.monday,
//             calendarStyle: CalendarStyle(
//               // Use `CalendarStyle` to customize the UI
//               outsideDaysVisible: false,
//             ),
//             onDaySelected: _onDaySelected,
//             onRangeSelected: _onRangeSelected,
//             onFormatChanged: (format) {
//               if (_calendarFormat != format) {
//                 setState(() {
//                   _calendarFormat = format;
//                 });
//               }
//             },
//             onPageChanged: (focusedDay) {
//               _focusedDay = focusedDay;
//             },
//           ),
//           const SizedBox(height: 8.0),
//           Expanded(
//             child: ValueListenableBuilder<List<Event>>(
//               valueListenable: _selectedEvents,
//               builder: (context, value, _) {
//                 return ListView.builder(
//                   itemCount: value.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 12.0,
//                         vertical: 4.0,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                       child: ListTile(
//                         onTap: () => print('${value[index]}'),
//                         title: Text('${value[index]}'),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
