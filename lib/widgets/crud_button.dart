import 'package:flutter/material.dart';
import 'package:property_service_web/core/constants/app_colors.dart';
import 'package:property_service_web/core/enums/button_type.dart';



class CRUDButton extends StatelessWidget {
  final ButtonType buttonType;
  final VoidCallback? onPressed;

  const CRUDButton({
    super.key,
    required this.buttonType,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 36,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.color5, // 버튼 배경색 초록색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 둥근 테두리
            side: BorderSide(color: AppColors.color5),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonType.name,
          style: TextStyle(
            fontSize: 16, // 텍스트 크기 키우기
            fontWeight: FontWeight.w400, // 텍스트 두껍게
            color: Colors.white, // 텍스트 색상 흰색
          ),
        ),
      ),
    );
  }
}
