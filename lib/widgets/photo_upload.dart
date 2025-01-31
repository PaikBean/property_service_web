import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:property_service_web/core/constants/app_colors.dart';

class PhotoUpload extends StatefulWidget {
  final String label;
  final Function(List<Uint8List>) onImagesSelected; // 부모에게 데이터 전달

  const PhotoUpload({
    super.key,
    required this.label,
    required this.onImagesSelected,
  });

  @override
  State<PhotoUpload> createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  final List<Uint8List> _images = []; // 업로드된 이미지의 바이트 데이터 저장
  final List<String> _fileNames = []; // 업로드된 파일 이름 저장
  final List<int> _fileSizes = []; // 업로드된 파일 크기 저장
  int _selectedImageIndex = 0; // 대표 이미지 인덱스 (기본값은 첫 번째 이미지)

  Future<void> _pickImages() async {
    if (_images.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("최대 5장의 사진만 업로드할 수 있습니다.")),
      );
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      final selectedFiles = result.files;

      setState(() {
        for (var file in selectedFiles) {
          if (_images.length >= 5) break; // 최대 5장 제한
          _images.add(file.bytes!);
          _fileNames.add(file.name);
          _fileSizes.add(file.size);
        }
        widget.onImagesSelected(_images);

        if (_images.isNotEmpty && _selectedImageIndex >= _images.length) {
          _selectedImageIndex = 0;
        }
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      _fileNames.removeAt(index);
      _fileSizes.removeAt(index);

      if (_images.isEmpty) {
        _selectedImageIndex = 0;
      } else if (_selectedImageIndex == index) {
        _selectedImageIndex = 0;
      } else if (_selectedImageIndex > index) {
        _selectedImageIndex--;
      }
    });
  }

  void _setRepresentativeImage(int index) {
    setState(() {
      _selectedImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 텍스트 및 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _PhotoAddButton(onPressed: _pickImages),
            ],
          ),
          const SizedBox(height: 16),

          // 이미지 미리보기 영역
          Container(
            height: 208,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: _images.isEmpty
                ? const Center(
              child: Text(
                "사진을 업로드하세요.",
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _images.length,
              itemBuilder: (context, index) {
                final fileName = _fileNames[index];
                final fileSize =
                (_fileSizes[index] / (1024 * 1024)).toStringAsFixed(2); // MB로 변환
                final isRepresentative = _selectedImageIndex == index;

                return GestureDetector(
                  onTap: () => _setRepresentativeImage(index),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                _images[index],
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (isRepresentative)
                              Positioned(
                                top: 4,
                                left: 4,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.color4,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    "대표 이미지",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () => _removeImage(index),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 150,
                          child: Column(
                            children: [
                              Text(
                                fileName,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                              Text(
                                "$fileSize MB",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoAddButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _PhotoAddButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 40, // 정사각형 버튼 크기
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent), // 배경색 투명
          elevation: WidgetStateProperty.all(0), // 그림자 제거
          padding: WidgetStateProperty.all(EdgeInsets.zero), // 내부 여백 제거
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // 둥근 테두리
              side: BorderSide(color: AppColors.color5, width: 2), // 테두리 설정
            ),
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent), // hover 효과 제거
        ),
        onPressed: onPressed,
        child: Text(
          "업로드",
          style: TextStyle(
            fontSize: 14, // 텍스트 크기 키우기
            fontWeight: FontWeight.w500, // 텍스트 두껍게
            color: AppColors.color5,
          ),
        ),
      ),
    );
  }
}
