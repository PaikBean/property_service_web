import 'dart:typed_data';

class BuildingSummary {
  final int id;
  final Uint8List? representativeImage;
  final String buildingName;
  final String buildingPostCode;
  final String buildingAddress;

  BuildingSummary({
    required this.id,
    required this.representativeImage,
    required this.buildingName,
    required this.buildingPostCode,
    required this.buildingAddress,
  });
}
