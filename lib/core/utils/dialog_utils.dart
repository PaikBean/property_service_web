import 'package:flutter/material.dart';
import 'package:kpostal_web/kpostal_web.dart';
import 'package:property_service_web/core/enums/datepicker_type.dart';
import 'package:property_service_web/core/utils/custom_kakao_address_widget.dart';
import 'package:property_service_web/models/common/remark_add_request.dart';
import 'package:property_service_web/models/common/schedule_add_request.dart';
import 'package:property_service_web/views/client/enums/client_status_type.dart';
import 'package:property_service_web/views/client/enums/schedule_type.dart';
import 'package:property_service_web/views/client/models/client_detail_model.dart';
import 'package:property_service_web/views/client/models/revenue_register_model.dart';
import 'package:property_service_web/views/client/models/showing_property_model.dart';
import 'package:property_service_web/widgets/custom_datepicker.dart';
import 'package:property_service_web/widgets/custom_text_field.dart';
import 'package:property_service_web/widgets/rotating_house_indicator.dart';

import '../../views/client/client_list_view.dart';
import '../../views/client/enums/client_source_type.dart';
import '../../views/client/enums/client_type_code.dart';
import '../../views/client/models/client_update_model.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_enum_check_box_group.dart';
import '../../widgets/custom_enum_radio_group.dart';
import '../../widgets/grid/custom_grid.dart';
import '../../widgets/grid/custom_grid_model.dart';
import '../constants/app_colors.dart';
import '../enums/transaction_type.dart';

class DialogUtils {

  static Future<T?> showCustomDialog<T>({
    required BuildContext context,
    required String title,
    required Widget child,
    double maxWidth = 400,
    String confirmText = "저장",
    String cancelText = "취소",
    required Future<T?> Function() onConfirm, // ✅ Future<T?> 적용
  }) async {
    final result = await showDialog<T?>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // 테두리 둥근 정도
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
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
                      title,
                      style: const TextStyle(
                        fontSize: 20, // 제목 글자 크기
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  child,
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
                          onPressed: () async {
                            onConfirm();
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
    return result;
  }



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

  /// 보여줄 매물 추가 다이얼로그
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
              maxWidth: 880, // 다이얼로그 최대 너비
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
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 136,
                                  child: CustomDropdown(
                                    items: ["담당자", "임대인"],
                                    onChanged: (_){},
                                  ),
                                ),
                                SizedBox(width: 24),
                                Expanded(
                                  child: TextField(
                                    controller: TextEditingController(),
                                    decoration: InputDecoration(
                                      // hintText: widget.hintText ?? "예) 판교역로 166, 분당 주공, 백현동 532",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.color5,
                                          width: 2.0,
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.search, color: Colors.black),
                                        onPressed: () {
                                          setState(() {
                                            // _gridItemsFuture = widget.fetchGridItems(); // 검색 시 데이터 다시 불러오기
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: 960,
                              height: 240,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: ReusableGrid(
                                title: "매물 선택",
                                itemList: [],
                                    // ? []
                                    // : clientDetailModel!.showingPropertyList.map((property)=> BuildClientShowingPropertyItem(property: property, onDelete: fetchOnShowingPropertyDelete)).toList(),
                                columns: [
                                  CustomGridModel(header: "거래 유형", flex: 1),
                                  CustomGridModel(header: "매물 가격", flex: 1),
                                  CustomGridModel(header: "매물 형태", flex: 1),
                                  CustomGridModel(header: "매물 주소", flex: 2),
                                ],
                                // onPressAdd: clientDetailModel == null ? null : () => fetchOnShowingPropertyAdd(),
                                canDelete: true,
                                contentGridHeight: 150,
                                isToggle: false,
                              ),
                            ),
                          ],
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

  /// 고객 정보 수정 다이얼로그
  static Future<ClientUpdateModel?> showUpdateClientDialog({
    required BuildContext context,
    required ClientUpdateModel client,
    String confirmText = "저장",
    String cancelText = "취소",
  }) async {

    TextEditingController clientName = TextEditingController(text: client.clientName);
    TextEditingController clientPhoneNumber = TextEditingController(text: client.clientPhoneNumber);

    ClientType clientType = client.clientType;
    TextEditingController clientTypeOther = TextEditingController(text: client.clientTypeOther);

    ClientSource clientSource = client.clientSourceType;
    TextEditingController clientSourceOther = TextEditingController(text: client.clientSourceTypeOther);

    DateTime clientExpectedMoveInDate = client.clientExpectedMoveInDate;
    List<TransactionType> clientExpectedTradeTypeList = client.clientExpectedTradeTypeList;

    ClientUpdateModel? clientUpdateModel = await showDialog<ClientUpdateModel>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // 테두리 둥근 정도
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 1000, // 다이얼로그 최대 너비
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
                          "고객 정보 수정",
                          style: const TextStyle(
                            fontSize: 20, // 제목 글자 크기
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // 담당자는 일정 등록한 사람 그대로..
                      SizedBox(
                        width: 200,
                        child: CustomTextField(label: "성함", controller: clientName),
                      ),
                      SizedBox(
                        width: 800,
                        child: CustomTextField(
                            label: "전화번호", controller: clientPhoneNumber),
                      ),
                      SizedBox(
                        width: 1000,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomEnumRadioGroup<ClientType>(
                              title: "고객 유형",
                              options: ClientType.values,
                              groupValue: clientType,
                              onChanged: (value) =>
                                  setState(() {
                                    clientType = value!;
                                  }),
                              otherInput: ClientType.other,
                              otherLabel: "기타",
                              otherTextController: clientTypeOther,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 800,
                        child: CustomEnumRadioGroup<ClientSource>(
                          title: "유입 경로",
                          options: ClientSource.values,
                          // Enum 리스트를 전달
                          groupValue: clientSource,
                          onChanged: (value) =>
                              setState(() {
                                clientSource = value!;
                              }),
                          otherInput: ClientSource.other,
                          otherLabel: "기타",
                          otherTextController: clientSourceOther,
                        ),
                      ),
                      SizedBox(
                        width: 800,
                        child: CustomEnumCheckboxGroup<TransactionType>(
                          title: "거래 유형",
                          options: TransactionType.values, // TransactionType Enum 사용
                          selectedValues: clientExpectedTradeTypeList,
                          onChanged: (selected) {
                            setState(() {
                              clientExpectedTradeTypeList = selected; // 선택된 값으로 리스트 업데이트
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: CustomDatePicker(
                          datePickerType: DatePickerType.date,
                          label: "입주 예정일",
                          selectedDateTime: clientExpectedMoveInDate,
                          onChanged: (DateTime? date) {
                            setState(() {
                              clientExpectedMoveInDate = date!;
                            });
                          },
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

                                if(clientName.text.isEmpty) {
                                  DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "성함을 입력해주세요.");
                                } else if(clientPhoneNumber.text.isEmpty){
                                  DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "전화번호를 입력해주세요.");
                                } else if(clientExpectedTradeTypeList.isEmpty){
                                DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "거래 유형을 선택해 주세요.");
                                } else{
                                Navigator.of(context).pop(ClientUpdateModel(
                                  clientId: client.clientId,
                                  clientName: clientName.text,
                                  clientPhoneNumber: clientPhoneNumber.text,
                                  picManagerName: client.picManagerName,
                                  clientType: clientType,
                                  clientTypeOther: clientTypeOther.text,
                                  clientSourceType: clientSource,
                                  clientSourceTypeOther: clientSourceOther.text,
                                  clientExpectedMoveInDate: clientExpectedMoveInDate,
                                  clientExpectedTradeTypeList: clientExpectedTradeTypeList,
                                  ));
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

    return clientUpdateModel;
  }

  /// 고객 상태 변경
  static Future<ClientStatusType?> showChangeClientStatusDialog({
    required BuildContext context,
    required ClientStatusType clientStatusType, // 초기 상태 값
    String confirmText = "저장",
    String cancelText = "취소",
  }) async {
    ClientStatusType? updatedClientStatusType = clientStatusType; // 변경 가능한 상태 값

    ClientStatusType? result = await showDialog<ClientStatusType>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // 테두리 둥근 정도
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 800, // 다이얼로그 최대 너비
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
                          "고객 상태 수정",
                          style: const TextStyle(
                            fontSize: 20, // 제목 글자 크기
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 800,
                        child: CustomEnumRadioGroup<ClientStatusType>(
                          title: "고객 상태",
                          options: ClientStatusType.values, // Enum 리스트 전달
                          groupValue: updatedClientStatusType, // 현재 상태 값
                          onChanged: (value) => setState(() {
                            updatedClientStatusType = value; // 선택된 값 업데이트
                          }),
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
                                Navigator.of(context).pop(updatedClientStatusType); // 변경된 상태 값 반환
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

    return result; // 최종적으로 선택된 값 반환
  }

  /// 고객 매출 등록 다이얼로그
  static Future<RevenueRegisterModel?> showRevenueRegisterDialog({
    required BuildContext context,
    required ClientDetailModel client,
    required List<ShowingPropertyModel> showingPropertyList,
    String confirmText = "저장",
    String cancelText = "취소",
  }) async {
    TextEditingController commissionFee = TextEditingController();
    DateTime? moveInDate;
    DateTime? moveOutDate;

    int? selected;

    RevenueRegisterModel? revenueRegisterData = await showDialog<RevenueRegisterModel>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // 테두리 둥근 정도
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 800, // 다이얼로그 최대 너비
            ),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "매출 등록",
                          style: const TextStyle(
                            fontSize: 20, // 제목 글자 크기
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 960,
                        height: 240,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ReusableGrid(
                          title: "매물 선택",
                          itemList: showingPropertyList.map((property)=> BuildRevenueRegisterPropertyItem(
                              property: property,
                              onSelected: (id) async {
                                setState(() {  // StatefulBuilder의 setState 호출
                                  selected = id;
                                });
                              },
                              isSelected: selected == property.showingPropertyId,
                          )).toList(),
                          columns: [
                            CustomGridModel(header: "거래 유형", flex: 1),
                            CustomGridModel(header: "매물 가격", flex: 1),
                            CustomGridModel(header: "매물 형태", flex: 1),
                            CustomGridModel(header: "매물 주소", flex: 2),
                          ],
                          canDelete: false,
                          contentGridHeight: 150,
                          isToggle: false,
                        ),
                      ),
                      SizedBox(
                        width: 280,
                        child: CustomTextField(label: "중개 수수료", controller: commissionFee),
                      ),
                      SizedBox(
                        width: 960,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 280,
                              child: CustomDatePicker(
                                datePickerType: DatePickerType.date,
                                label: "입주일",
                                selectedDateTime: moveInDate,
                                onChanged: (DateTime? date) {
                                  setState(() {
                                    moveInDate = date;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 280,
                              child: CustomDatePicker(
                                datePickerType: DatePickerType.date,
                                label: "퇴실일",
                                selectedDateTime:  moveOutDate,
                                onChanged: (DateTime? date) {
                                  setState(() {
                                    moveOutDate = date;
                                  });
                                },
                              ),
                            ),
                          ],
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
                                if(selected == null) {
                                  DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "매물을 입력해주세요.");
                                } else if(commissionFee.text.isEmpty){
                                  DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "중개 수수료를 입력해주세요.");
                                } else if(moveInDate == null){
                                  DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "입주일을 선택해 주세요.");
                                } else if(moveOutDate == null){
                                  DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "퇴실일을 선택해 주세요.");
                                } else if(moveInDate!.isAfter(moveOutDate!)){
                                  DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "퇴실일은 입주일 이전일 수 없습니다.");
                                } else{
                                  Navigator.of(context).pop(RevenueRegisterModel(
                                      clientId: client.clientId,
                                      propertyId: selected!,
                                      commissionFee: int.parse(commissionFee.text),
                                      moveInDate: moveInDate!,
                                      moveOutDate: moveOutDate!
                                  )); // 변경된 상태 값 반환
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

    return revenueRegisterData;
  }
}
