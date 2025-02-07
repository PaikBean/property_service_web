import 'package:flutter/material.dart';
import 'package:kpostal_web/kpostal_web.dart';
import 'package:property_service_web/core/enums/datepicker_type.dart';
import 'package:property_service_web/core/utils/custom_kakao_address_widget.dart';
import 'package:property_service_web/models/common/remark_add_request.dart';
import 'package:property_service_web/models/common/schedule_add_request.dart';
import 'package:property_service_web/views/client/enums/schedule_type.dart';
import 'package:property_service_web/widgets/custom_datepicker.dart';
import 'package:property_service_web/widgets/custom_text_field.dart';
import 'package:property_service_web/widgets/rotating_house_indicator.dart';

import '../../widgets/custom_enum_radio_group.dart';
import '../constants/app_colors.dart';

class DialogUtils {
  /// 경고 메시지를 보여주는 다이얼로그
  static Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = "확인",
  }) async {
    await showDialog(
      context: context,
      builder: (context)  {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // 테두리 둥근 정도
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20, // 제목 글자 크기
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 16, // 내용 글자 크기
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(AppColors.color5.withAlpha(32)),
              ),
              child: Text(
                confirmText,
                style: const TextStyle(
                  fontSize: 16, // 버튼 글자 크기
                  fontWeight: FontWeight.w600,
                  color: AppColors.color5
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 확인 메시지를 보여주는 다이얼로그
  static Future<bool> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = "확인",
    String cancelText = "취소",
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // 테두리 둥근 정도
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20, // 제목 글자 크기
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14, // 내용 글자 크기
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // "취소" 선택 시 false 반환
              },
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(AppColors.color5.withAlpha(32)),
              ),
              child: Text(
                cancelText,
                style: const TextStyle(
                  fontSize: 16, // 버튼 글자 크기
                  fontWeight: FontWeight.w600,
                  color: AppColors.color5,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // "확인" 선택 시 true 반환
              },
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(AppColors.color5.withAlpha(32)),
              ),
              child: Text(
                confirmText,
                style: const TextStyle(
                  fontSize: 16, // 버튼 글자 크기
                  fontWeight: FontWeight.w600,
                  color: AppColors.color5,
                ),
              ),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  /// 주소 찾기 다이얼로그
  static Future<KakaoAddress?> showAddressSearchDialog({
    required BuildContext context,
  }) async {
    bool isPopped = false; // 다이얼로그가 닫혔는지 확인하는 플래그

    return await showDialog<KakaoAddress>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            width: 480,
            height: 640,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "주소찾기",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (!isPopped) {
                          isPopped = true;
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        }
                      },
                      icon: Icon(
                        Icons.close,
                        size: 32,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Stack(
                    children: [
                      Center(
                        child: RotatingHouseIndicator(),
                      ),
                      SingleChildScrollView(
                        child: CustomKakaoAddressWidget(
                          onComplete: (KakaoAddress kakaoAddress) {
                            if (!isPopped) {
                              Navigator.of(context).pop(kakaoAddress); // 주소 데이터를 반환하며 다이얼로그 닫기
                              isPopped = true;
                            }
                          },
                          onClose: () {
                            if (!isPopped) {
                              Navigator.of(context).pop(); // 다이얼로그 닫기
                              isPopped = true;
                            }
                          },
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
    );
  }

  /// 특이사항을 입력 받는 다이얼로그
  static Future<RemarkAddRequest?> showAddRemarkDialog({
    required BuildContext context,
    String confirmText = "저장",
    String cancelText = "취소",
  }) async {
    TextEditingController remarkController = TextEditingController();
    RemarkAddRequest? remarkAddRequest = await showDialog<RemarkAddRequest>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // 테두리 둥근 정도
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 400, // 다이얼로그 최대 너비
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "특이사항 추가",
                      style: const TextStyle(
                        fontSize: 20, // 제목 글자 크기
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      label: "특이사항",
                      controller: remarkController,
                      maxLines: 4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // "취소" 선택 시 닫기
                          },
                          style: ButtonStyle(
                            overlayColor: WidgetStateProperty.all(
                              AppColors.color5.withAlpha(32),
                            ),
                          ),
                          child: Text(
                            cancelText,
                            style: const TextStyle(
                              fontSize: 16, // 버튼 글자 크기
                              fontWeight: FontWeight.w600,
                              color: AppColors.color5,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if(remarkController.text.isEmpty) {
                              DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "특이사항을 입력해주세요.");
                            } else{
                              Navigator.of(context).pop(
                                RemarkAddRequest(remark: remarkController.text),
                              );
                            }
                          },
                          style: ButtonStyle(
                            overlayColor: WidgetStateProperty.all(
                              AppColors.color5.withAlpha(32),
                            ),
                          ),
                          child: Text(
                            confirmText,
                            style: const TextStyle(
                              fontSize: 16, // 버튼 글자 크기
                              fontWeight: FontWeight.w600,
                              color: AppColors.color5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    return remarkAddRequest;
  }

  /// 일정 추가 다이얼로그
  static Future<ScheduleAddRequest?> showAddScheduleDialog({
    required BuildContext context,
    String confirmText = "저장",
    String cancelText = "취소",
  }) async {
    
    DateTime? scheduleDatetime;
    ScheduleType? scheduleType;
    TextEditingController remarkController = TextEditingController();

    ScheduleAddRequest? scheduleAddRequest = await showDialog<ScheduleAddRequest>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // 테두리 둥근 정도
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 400, // 다이얼로그 최대 너비
            ),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "일정 추가",
                          style: const TextStyle(
                            fontSize: 20, // 제목 글자 크기
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // 담당자는 일정 등록한 사람 그대로..
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomDatePicker(
                          label: "일시",
                          datePickerType: DatePickerType.datetime,
                          selectedDateTime: scheduleDatetime,
                          onChanged: (newDateTime) {
                            setState(() {
                              scheduleDatetime = newDateTime; // 상태 업데이트
                            });
                          },
                        ),
                      ),
                      CustomEnumRadioGroup<ScheduleType>(
                        title: "일정 유형",
                        options: ScheduleType.values,
                        groupValue: scheduleType,
                        onChanged: (value) {
                          setState(() {
                            scheduleType = value; // 상태 업데이트
                          });
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          label: "특이사항",
                          controller: remarkController,
                          maxLines: 4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // "취소" 선택 시 닫기
                              },
                              style: ButtonStyle(
                                overlayColor: WidgetStateProperty.all(
                                  AppColors.color5.withAlpha(32),
                                ),
                              ),
                              child: Text(
                                cancelText,
                                style: const TextStyle(
                                  fontSize: 16, // 버튼 글자 크기
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.color5,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if(scheduleDatetime == null) {
                                  DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "일시를 입력해주세요.");
                                } else if(scheduleType == null){
                                  DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "일정 유형을 선택해주세요.");
                                } else{
                                  Navigator.of(context).pop(
                                      ScheduleAddRequest(scheduleDateTime: scheduleDatetime!, scheduleType: scheduleType!, scheduleRemark: remarkController.text)
                                  );
                                }
                              },
                              style: ButtonStyle(
                                overlayColor: WidgetStateProperty.all(
                                  AppColors.color5.withAlpha(32),
                                ),
                              ),
                              child: Text(
                                confirmText,
                                style: const TextStyle(
                                  fontSize: 16, // 버튼 글자 크기
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.color5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );

    return scheduleAddRequest;
  }

  static Future<ScheduleAddRequest?> showAddShowingPropertyDialog({
    required BuildContext context,
    String confirmText = "저장",
    String cancelText = "취소",
  }) async {

    DateTime? scheduleDatetime;
    ScheduleType? scheduleType;
    TextEditingController remarkController = TextEditingController();

    ScheduleAddRequest? scheduleAddRequest = await showDialog<ScheduleAddRequest>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // 테두리 둥근 정도
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 400, // 다이얼로그 최대 너비
            ),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "보여줄 매물 추가",
                          style: const TextStyle(
                            fontSize: 20, // 제목 글자 크기
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // 담당자는 일정 등록한 사람 그대로..
                      Text("구상 중"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // "취소" 선택 시 닫기
                              },
                              style: ButtonStyle(
                                overlayColor: WidgetStateProperty.all(
                                  AppColors.color5.withAlpha(32),
                                ),
                              ),
                              child: Text(
                                cancelText,
                                style: const TextStyle(
                                  fontSize: 16, // 버튼 글자 크기
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.color5,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {

                                  Navigator.of(context).pop();

                              },
                              style: ButtonStyle(
                                overlayColor: WidgetStateProperty.all(
                                  AppColors.color5.withAlpha(32),
                                ),
                              ),
                              child: Text(
                                confirmText,
                                style: const TextStyle(
                                  fontSize: 16, // 버튼 글자 크기
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.color5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );

    return scheduleAddRequest;
  }
}
