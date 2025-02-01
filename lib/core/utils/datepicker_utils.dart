import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class DatePickerUtils {

  static Future<DateTime?> selectYearMonth(BuildContext context, DateTime? initialDate) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      locale: const Locale('ko', 'KR'),
      initialEntryMode: DatePickerEntryMode.input, // 텍스트 입력 모드
      fieldHintText: "YYYY-MM", // 연월 입력 힌트
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.color5,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      return DateTime(selectedDate.year, selectedDate.month);
    }
    return null;
  }

  /// 날짜 선택기
  static Future<DateTime?> selectDate(BuildContext context, DateTime? initialDate) async {
    DateTime? selectedDate =  await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(), // 기본 날짜
      firstDate: DateTime(1900), // 선택 가능한 최소 날짜
      lastDate: DateTime(2100), // 선택 가능한 최대 날짜
      locale: const Locale('ko', 'KR'), // 한글 설정
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.color5, // 강조 색상
              onPrimary: Colors.white, // 텍스트 색상
              onSurface: Colors.black, // 텍스트 색상
            ),
          ),
          child: child!,
        );
      },
    );

    if(selectedDate != null){
      return selectedDate;
    }
    return null;
  }
}
