import 'package:property_service_web/views/client/enums/schedule_type.dart';

class ScheduleAddRequest {
  final DateTime scheduleDateTime;
  final ScheduleType scheduleType;
  final String scheduleRemark;

  ScheduleAddRequest({
    required this.scheduleDateTime,
    required this.scheduleType,
    required this.scheduleRemark,
  });

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'scheduleDateTime' : scheduleDateTime,
      'scheduleTypeCode': scheduleType.code,
      'scheduleRemark': scheduleRemark,
    };
  }
}
