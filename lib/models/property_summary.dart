import 'dart:typed_data';

class PropertySummary {
  final int id;
  final Uint8List? representativeImage;
  final String buildingName;
  final String buildingPostCode;
  final String buildingAddress;
  final String propertyRoomNumber;
  final String propertySellType;
  final String propertyPrice;

  PropertySummary({
    required this.id,
    required this.representativeImage,
    required this.buildingName,
    required this.buildingPostCode,
    required this.buildingAddress,
    required this.propertyRoomNumber,
    required this.propertySellType,
    required this.propertyPrice,
  });
}
