import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:property_service_web/widgets/custom_text_field.dart';
import '../../widgets/custom_dropdown.dart';
import '../constants/app_colors.dart';

class DatePickerUtils {

  // static Future<DateTime?> selectYearMonth(BuildContext context, DateTime? initialDate) async {
  //   DateTime? selectedDate = await showDatePicker(
  //     context: context,
  //     initialDate: initialDate ?? DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2100),
  //     locale: const Locale('ko', 'KR'),
  //     initialEntryMode: DatePickerEntryMode.input, // 텍스트 입력 모드
  //     fieldHintText: "YYYY-MM", // 연월 입력 힌트
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: ColorScheme.light(
  //             primary: AppColors.color5,
  //             onPrimary: Colors.white,
  //             onSurface: Colors.black,
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //
  //   if (selectedDate != null) {
  //     return DateTime(selectedDate.year, selectedDate.month);
  //   }
  //   return null;
  // }

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

  // 년 월 선택기
  static Future<DateTime?> selectYearMonth(BuildContext context, DateTime? initialDate) async {
    DateTime selectedDate = initialDate ?? DateTime.now();
    TextEditingController yearController = TextEditingController(text: selectedDate.year.toString());
    int selectedYear = selectedDate.year;
    int selectedMonth = selectedDate.month;

    return await showDialog<DateTime>(
      context: context,
      barrierDismissible: true, // 외부 탭 시 닫힘
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent, // 배경 투명
              child: Container(
                width: 360,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32), // 둥근 모서리
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "년·월 선택",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: yearController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: AppColors.color5, width: 2.0),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          selectedYear = int.tryParse(value) ?? selectedYear;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      child: Icon(
                                        Icons.arrow_drop_up,
                                        size: 24,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedYear++;
                                          yearController.text = selectedYear.toString();
                                        });
                                      },
                                    ),
                                    SizedBox(height: 4),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 24,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedYear--;
                                          yearController.text = selectedYear.toString();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // 월 선택 그리드 (4x3)
                      Container(
                        height: 244,
                        padding: EdgeInsets.all(16),
                        child: GridView.count(
                          crossAxisCount: 4, // 4x3 그리드
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          shrinkWrap: true, // 크기 자동 조절
                          children: List.generate(12, (index) {
                            int month = index + 1;
                            bool isSelected = selectedMonth == month;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedMonth = month; // UI 즉시 업데이트
                                });
                              },
                              child: Container(
                                width: 40, // 기존 80에서 절반 축소
                                height: 40, // 기존 80에서 절반 축소
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.color4 : Colors.transparent,
                                  borderRadius: BorderRadius.circular(64),
                                ),
                                child: Text(
                                  "$month월",
                                  style: TextStyle(
                                    fontSize: 14, // 기존 14에서 축소
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      // 버튼 (취소 & 선택)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(null), // 취소 시 null 반환
                            style: ButtonStyle(
                              overlayColor: WidgetStateProperty.all(AppColors.color5.withAlpha(32)),
                            ),
                            child: Text(
                              "취소",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.color5,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(DateTime(selectedYear, selectedMonth)), // 선택한 년월 반환
                            style: ButtonStyle(
                              overlayColor: WidgetStateProperty.all(AppColors.color5.withAlpha(32)),
                            ),
                            child: Text(
                              "선택",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.color5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
