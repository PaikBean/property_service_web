class ClientScheduleItemModel {
  final int id;
  final String scheduleManager;
  final String scheduleDateTime;
  final String clientName;
  final String scheduleType;

  ClientScheduleItemModel({
    required this.id,
    required this.scheduleManager,
    required this.scheduleDateTime,
    required this.clientName,
    required this.scheduleType,
  });
}