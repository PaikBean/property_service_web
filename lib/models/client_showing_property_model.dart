class ClientShowingPropertyModel {
  final int id;
  final String propertySellType;
  final String propertySellAmount;
  final String propertyAddress;
  final String propertyType;

  // 매물 거래 유형
  // 매물 거래 가격
  // 주소
  // 매물 형태
  ClientShowingPropertyModel({
    required this.id,
    required this.propertySellType,
    required this.propertySellAmount,
    required this.propertyAddress,
    required this.propertyType,
  });
}
