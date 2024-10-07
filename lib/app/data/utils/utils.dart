import 'dart:collection';
import 'dart:math';

import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final String description;
  final String time;

  const Event(this.title, this.description, this.time);

  @override
  String toString() => title;
}

String pilihKalimatSecaraAcak() {
  List<String> kalimatList = [
    'Membuat design home',
    'Mengerjakan Kuis Dicoding',
    'Membuat alur sistem',
    ''
  ];

  kalimatList.shuffle(Random());

  // Mengambil satu kalimat secara acak
  return kalimatList.first;
}

String pilihJamSecaraAcak() {
  List<String> kalimatList = ['18:00', '13:12', '19:11', '11:15'];

  kalimatList.shuffle(Random());

  // Mengambil satu kalimat secara acak
  return kalimatList.first;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1,
        (index) => Event(
            '${index + 1}', pilihKalimatSecaraAcak(), pilihJamSecaraAcak())))
  ..addAll({
    kToday: [
      Event(' 1', 'Membuat Dashboard Ui', "18:00"),
      Event(' 2', 'Mengerjakan Kuis', "07:00"),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
