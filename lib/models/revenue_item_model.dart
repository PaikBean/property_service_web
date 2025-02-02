class RevenueItemModel {
  final int id;
  final String managerName;
  final String clientName;
  final String clientSource;
  final String propertyOwnerName;
  final String propertyAddress;
  final String propertySellType;
  final String propertySellPrice;
  final String commissionFee;
  final String moveInDate;

  RevenueItemModel({
    required this.id,
    required this.managerName,
    required this.clientName,
    required this.clientSource,
    required this.propertyOwnerName,
    required this.propertyAddress,
    required this.propertySellType,
    required this.propertySellPrice,
    required this.commissionFee,
    required this.moveInDate,
  });
}
