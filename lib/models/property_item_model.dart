class PropertyItemModel {
  final int id;
  final String transactionType;
  final String price;
  final String address;
  final String propertyOwner;
  final String propertyManager;
  final String propertyStatus;

  PropertyItemModel({
    required this.id,
    required this.transactionType,
    required this.price,
    required this.address,
    required this.propertyOwner,
    required this.propertyManager,
    required this.propertyStatus,
  });
}