class RemarkModel {
  final int clientRemarkId;
  final String clientRemark;
  final int createdByUserId;
  final String createByUserName;
  final String createdBy;
  final DateTime createdAt;

  RemarkModel({
    required this.clientRemarkId,
    required this.clientRemark,
    required this.createdByUserId,
    required this.createByUserName,
    required this.createdBy,
    required this.createdAt,
  });

  // JSON으로부터 생성
  factory RemarkModel.fromJson(Map<String, dynamic> json) {
    return RemarkModel(
      clientRemarkId: json['clientRemarkId'],
      clientRemark: json['clientRemark'],
      createdByUserId: json['createdByUserId'],
      createByUserName: json['createByUserName'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
    );
  }
}
