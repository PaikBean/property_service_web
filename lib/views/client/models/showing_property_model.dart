class ShowingPropertyModel {
  final int showingPropertyId;
  final String propertySellType;
  final String propertyPrice;
  final String propertyType;
  final String propertyAddress;

  //거래유형, 매물 가격, 매물 형태, 매물 주소

  ShowingPropertyModel({
    required this.showingPropertyId,
    required this.propertySellType,
    required this.propertyPrice,
    required this.propertyType,
    required this.propertyAddress,
  });

  // JSON으로부터 생성
  factory ShowingPropertyModel.fromJson(Map<String, dynamic> json) {
    return ShowingPropertyModel(
      showingPropertyId: json['showingPropertyId'],
      propertySellType: json['propertySellType'],
      propertyPrice: json['propertyPrice'],
      propertyType: json['propertyType'],
      propertyAddress: json['propertyAddress'],
    );
  }
}
