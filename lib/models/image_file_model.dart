import 'dart:typed_data';

class ImageFileModel {
  final Uint8List imageBytes;
  final String imageName;
  final int imageSize;

  ImageFileModel({
    required this.imageBytes,
    required this.imageName,
    required this.imageSize,
  });
}
