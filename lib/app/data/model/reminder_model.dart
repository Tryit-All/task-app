class ReminderModel {
  final String? title;
  final String? eventDate;
  final String? eventTime;

  ReminderModel({
    this.title,
    this.eventDate,
    this.eventTime,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      title: json['title'] as String? ?? '',
      eventDate: json['eventDate'] as String? ?? '',
      eventTime: json['eventTime'] as String? ?? '',
    );
  }
}
