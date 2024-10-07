import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_app/app/data/utils/utils.dart';

class KalenderController extends GetxController {
  //TODO: Implement KalenderController

  final count = 0.obs;
  var selectedEvents = <Event>[].obs;
  var calendarFormat = CalendarFormat.month.obs;
  var rangeSelectionMode = RangeSelectionMode.toggledOff.obs;
  var focusedDay = DateTime.now().obs;
  var selectedValue = 0.obs;
  var selectedDay = Rxn<DateTime>();
  var rangeStart = Rxn<DateTime>();
  var rangeEnd = Rxn<DateTime>();
  var isSwitchOn = false.obs;
  var powerOn = false.obs;
  // var currentDate = DateTime(2019, 2, 3).obs;
  // var currentDate2 = DateTime(2019, 2, 3).obs;
  // var currentMonth = ''.obs;
  // var targetDateTime = DateTime(2019, 2, 3).obs;

  // static Widget eventIcon = Container(
  //   decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.all(Radius.circular(1000)),
  //       border: Border.all(color: Colors.blue, width: 2.0)),
  //   child: Icon(
  //     Icons.person,
  //     color: Colors.amber,
  //   ),
  // );

  // EventList<Event> markedDateMap = EventList<Event>(
  //   events: {
  //     DateTime(2019, 2, 10): [
  //       Event(
  //         date: DateTime(2019, 2, 10),
  //         title: 'Event 1',
  //         icon: eventIcon,
  //       ),
  //       Event(
  //         date: DateTime(2019, 2, 10),
  //         title: 'Event 2',
  //         icon: eventIcon,
  //       ),
  //       Event(
  //         date: DateTime(2019, 2, 10),
  //         title: 'Event 3',
  //         icon: eventIcon,
  //       ),
  //     ],
  //   },
  // );

  @override
  void onInit() {
    super.onInit();
    selectedDay.value = focusedDay.value;
    loadEventsForDay(selectedDay.value!);
    // currentMonth.value = DateFormat.yMMM().format(targetDateTime.value);
    // markedDateMap.add(
    //   DateTime(2019, 2, 25),
    //   Event(
    //     date: DateTime(2019, 2, 25),
    //     title: 'Event 5',
    //     icon: eventIcon,
    //   ),
    // );
    // markedDateMap.add(
    //   DateTime(2019, 2, 10),
    //   Event(
    //     date: DateTime(2019, 2, 10),
    //     title: 'Event 4',
    //     icon: eventIcon,
    //   ),
    // );
    // markedDateMap.addAll(
    //   DateTime(2019, 2, 11),
    //   [
    //     Event(
    //       date: DateTime(2019, 2, 11),
    //       title: 'Event 1',
    //       icon: eventIcon,
    //     ),
    //     Event(
    //       date: DateTime(2019, 2, 11),
    //       title: 'Event 2',
    //       icon: eventIcon,
    //     ),
    //     Event(
    //       date: DateTime(2019, 2, 11),
    //       title: 'Event 3',
    //       icon: eventIcon,
    //     ),
    //   ],
    // );
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

  void setSelectedValue(int value) {
    selectedValue.value = value;
  }

  void setView() {
    if (powerOn.value != true) {
      powerOn.value = !powerOn.value;
    } else {
      powerOn.value = false;
    }
  }

  void loadEventsForDay(DateTime day) {
    selectedEvents.value = kEvents[day] ?? [];
  }

  void loadEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    selectedEvents.value = [
      for (final d in days) ...kEvents[d] ?? [],
    ];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay.value, selectedDay)) {
      this.selectedDay.value = selectedDay;
      this.focusedDay.value = focusedDay;
      rangeStart.value = null;
      rangeEnd.value = null;
      rangeSelectionMode.value = RangeSelectionMode.toggledOff;

      loadEventsForDay(selectedDay);
    }
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    selectedDay.value = null;
    this.focusedDay.value = focusedDay;
    rangeStart.value = start;
    rangeEnd.value = end;
    rangeSelectionMode.value = RangeSelectionMode.toggledOn;

    if (start != null && end != null) {
      loadEventsForRange(start, end);
    } else if (start != null) {
      loadEventsForDay(start);
    } else if (end != null) {
      loadEventsForDay(end);
    }
  }

  void onFormatChanged(CalendarFormat format) {
    if (calendarFormat.value != format) {
      calendarFormat.value = format;
    }
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay.value = focusedDay;
  }

  List<Event> getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }
}
