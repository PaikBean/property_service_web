class RemarkModel {
  final int remarkId;
  final String remark;
  final int createdByUserId;
  final String createByUserName;
  final String createdBy;
  final DateTime createdAt;

  RemarkModel({
    required this.remarkId,
    required this.remark,
    required this.createdByUserId,
    required this.createByUserName,
    required this.createdBy,
    required this.createdAt,
  });

  // JSON으로부터 생성
  factory RemarkModel.fromJson(Map<String, dynamic> json) {
    return RemarkModel(
      remarkId: json['remarkId'],
      remark: json['remark'],
      createdByUserId: json['createdByUserId'],
      createByUserName: json['createByUserName'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
    );
  }
}
