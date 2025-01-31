import 'package:flutter/material.dart';
import 'package:property_service_web/core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool readOnly;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.maxLines,
    this.readOnly = false, // 기본값 설정
    this.obscureText = false, // 기본값 설정
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        obscureText: obscureText,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: label,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder( // 포커스 상태 경계선
            borderSide: BorderSide(
              color: AppColors.color5, // 초록색 강조
              width: 2.0, // 경계선 두께
            ),
          ),
          labelStyle: TextStyle(
            color: AppColors.color5, // 라벨 텍스트 색상
          ),
        ),
      ),
    );
  }
}
