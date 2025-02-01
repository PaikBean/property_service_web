import 'dart:typed_data';

class ImageFileModel {
  final Uint8List imageBytes;
  final String fileName;
  final int fileSize;

  ImageFileModel({
    required this.imageBytes,
    required this.fileName,
    required this.fileSize,
  });
}
