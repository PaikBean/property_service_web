class RevenueRegisterModel {
  final int clientId;
  final int propertyId;
  final int commissionFee;
  final DateTime moveInDate;
  final DateTime moveOutDate;

  RevenueRegisterModel({
    required this.clientId,
    required this.propertyId,
    required this.commissionFee,
    required this.moveInDate,
    required this.moveOutDate,
  });

  // JSON으로부터 객체 생성
  factory RevenueRegisterModel.fromJson(Map<String, dynamic> json) {
    return RevenueRegisterModel(
      clientId: json['clientId'],
      propertyId: json['propertyId'],
      commissionFee: json['commissionFee'],
      moveInDate: DateTime.parse(json['moveInDate']),
      moveOutDate: DateTime.parse(json['moveOutDate']),
    );
  }

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'propertyId': propertyId,
      'commissionFee': commissionFee,
      'moveInDate': moveInDate.toIso8601String(),
      'moveOutDate': moveOutDate.toIso8601String(),
    };
  }
}
