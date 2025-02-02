import 'dart:typed_data';

class CalendarScheduleSummaryModel {
  final int id;
  final String scheduleDateTime;
  final String scheduleManage;
  final String scheduleClientName;
  final String scheduleType;

  CalendarScheduleSummaryModel({
    required this.id,
    required this.scheduleDateTime,
    required this.scheduleManage,
    required this.scheduleClientName,
    required this.scheduleType,
  });
}
