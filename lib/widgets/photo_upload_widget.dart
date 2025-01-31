import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PhotoUploadWidget extends StatefulWidget {
  const PhotoUploadWidget({super.key});

  @override
  State<PhotoUploadWidget> createState() => _PhotoUploadWidgetState();
}

class _PhotoUploadWidgetState extends State<PhotoUploadWidget> {
  Uint8List? _imageBytes; // 선택한 이미지의 바이트 데이터
  String? _fileName; // 선택한 파일 이름

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image, // 이미지 파일만 선택 가능
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _imageBytes = result.files.first.bytes; // 이미지의 바이트 데이터 저장
        _fileName = result.files.first.name; // 파일 이름 저장
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "사진 업로드",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage, // 사진 업로드 버튼 클릭 이벤트
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: _imageBytes == null
                ? Center(
              child: Icon(Icons.upload, size: 50, color: Colors.grey),
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                _imageBytes!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (_fileName != null)
          Text(
            "파일 이름: $_fileName",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        if (_imageBytes != null)
          ElevatedButton(
            onPressed: () {
              setState(() {
                _imageBytes = null; // 이미지 초기화
                _fileName = null; // 파일 이름 초기화
              });
            },
            child: const Text("이미지 삭제"),
          ),
      ],
    );
  }
}
