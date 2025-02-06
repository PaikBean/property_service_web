class ClientScheduleModel {
  final int clientScheduleId;
  final String picManagerName;
  final String clientScheduleDateTime;
  final String clientScheduleType;
  final String clientScheduleRemark;

  ClientScheduleModel({
    required this.clientScheduleId,
    required this.picManagerName,
    required this.clientScheduleDateTime,
    required this.clientScheduleType,
    required this.clientScheduleRemark,
  });

  // JSON으로부터 생성
  factory ClientScheduleModel.fromJson(Map<String, dynamic> json) {
    return ClientScheduleModel(
      clientScheduleId: json['clientScheduleId'],
      picManagerName: json['picManagerName'],
      clientScheduleDateTime: json['clientScheduleDateTime'],
      clientScheduleType: json['clientScheduleType'],
      clientScheduleRemark: json['clientScheduleRemark'],
    );
  }
}
