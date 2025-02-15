  import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
  import 'package:property_service_web/core/enums/gender_type.dart';
  import 'package:property_service_web/core/utils/dialog_utils.dart';
  import 'package:property_service_web/core/utils/format_utils.dart';
  import 'package:property_service_web/views/client/models/client_register_model.dart';

  import '../../core/enums/button_type.dart';
  import '../../core/enums/datepicker_type.dart';
  import '../../core/enums/main_screen_type.dart';
  import '../../core/enums/transaction_type.dart';
  import '../../widgets/custom_check_box_group.dart';
import '../../widgets/custom_datepicker.dart';
  import '../../widgets/custom_enum_check_box_group.dart';
  import '../../widgets/custom_enum_radio_group.dart';
  import '../../widgets/custom_radio_group.dart';
import '../../widgets/custom_text_field.dart';
  import '../../widgets/rotating_house_indicator.dart';
import '../../widgets/sub_layout.dart';
  import '../auth/login_view.dart';
import 'enums/client_source_type.dart';
  import 'enums/client_type_code.dart';

  class ClientRegisterView extends StatefulWidget {
    const ClientRegisterView({super.key});

    @override
    State<ClientRegisterView> createState() => _ClientRegisterViewState();
  }

  class _ClientRegisterViewState extends State<ClientRegisterView>  {
    bool _isLoading = false;

    TextEditingController name = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();
    String? gender;
    String? type;
    TextEditingController typeTextController = TextEditingController();
    String? source;
    TextEditingController sourceTextController = TextEditingController();
    List<String> transactionTypeList = [];
    DateTime? clientExpectedMoveInDate;
    TextEditingController remark = TextEditingController();

    void onSubmit() async {
      setState(() {
        _isLoading = true; // 로딩 시작
      });

      try{
        // JWT 토큰 가져오기
        String? token = await storage.read(key: 'jwt');

        // 거래 유형을 숫자로 변환하는 매핑
        List<int> transactionTypeCodeList = transactionTypeList.map((type) {
          switch (type) {
            case "월세":
              return 61;
            case "전세":
              return 62;
            case "단기":
              return 64;
            default:
              return -1; // 혹시 모를 예외 처리용 (사용하지 않을 값)
          }
        }).where((code) => code != -1).toList(); // -1 제외


        // Dio를 사용한 POST 요청
        final response = await dio.post(
          'http://localhost:8080/api/client/', // 여기에 서버의 실제 URL 입력
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': '$token', // JWT 토큰 포함
            },
          ),
          data: jsonEncode({
            'name': name.text,
            'phoneNumber': phoneNumber.text,
            'genderCode': gender == "남성" ? 31 : 32,
            'source': source == "기타" ? sourceTextController.text : source,
            'type': type == "기타" ? typeTextController : type,
            'moveInDate':  clientExpectedMoveInDate!.toIso8601String(),
            'expectedTransactionTypeCodeList': transactionTypeCodeList,
            'remark': remark.text,
          }),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          await DialogUtils.showAlertDialog(
              context: context,
              title: "등록 성공",
              content: "${name.text} 고객님이 성공적으로 등록되었습니다.");
          clearAllData();
        } else {
          await DialogUtils.showAlertDialog(
              context: context,
              title: "등록 실패",
              content: "오류 코드: ${response.statusCode}");
        }

      } catch (e) {
        print("고객 등록 실패: $e");
        DialogUtils.showAlertDialog(context: context, title: "고객 등록 실패", content: "고객 등록에 실패했습니다.");
      } finally{
        setState(() {
          _isLoading = false; // 로딩 종료
        });
      }
    }

    void clearAllData() {
      setState(() {
        // TextEditingController 초기화
        name.text = "";
        phoneNumber.text = "";
        typeTextController.text = "";
        sourceTextController.text = "";
        remark.text = "";

        // nullable 타입 초기화
        gender = null;
        type = null;
        source = null;
        clientExpectedMoveInDate = null;

        // 리스트 초기화
        transactionTypeList.clear();
      });
    }

    @override
    Widget build(BuildContext context) {
      return Stack(
        children: [
          SubLayout(
              mainScreenType: MainScreenType.ClientRegister,
              buttonTypeList: [ButtonType.submit],
              onSubmitPressed: onSubmit,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: CustomTextField(label: "성함", controller: name),
                      ),
                      SizedBox(
                        width: 400,
                        child: CustomTextField(
                            label: "전화번호", controller: phoneNumber),

                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: CustomRadioGroup(
                          title: "성별",
                          options: ["남성", "여성",],
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 600,
                        child: CustomRadioGroup(
                          title: "고객 유형",
                          options: ["학생", "직장인", "외국인", "기타"],
                          groupValue: type,
                          onChanged: (value) {
                            setState(() {
                              type = value;
                            });
                          },
                          otherInput: "기타", // "기타" 선택 시 입력 필드 표시
                          otherLabel: "기타 입력",
                          otherInputTextController: typeTextController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 800,
                    child: CustomRadioGroup(
                      title: "유입 경로",
                      options: ["직방", "다방", "피터팬", "워킹", "기타"],
                      groupValue: source,
                      onChanged: (value) {
                        setState(() {
                          source = value;
                        });
                      },
                      otherInput: "기타", // "기타" 선택 시 입력 필드 표시
                      otherLabel: "기타 입력",
                      otherInputTextController: sourceTextController,
                    ),
                  ),
                  SizedBox(
                    width: 800,
                    child: CustomCheckboxGroup(
                      title: "거래 유형",
                      options: ["월세", "전세", "단기"],
                      onChanged: (values) {
                        setState(() {
                          transactionTypeList = values;
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
                          clientExpectedMoveInDate = date;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 800,
                    child: CustomTextField(
                      label: "특이사항",
                      controller: remark,
                      maxLines: 4,
                    ),
                  ),
                ],
              )
          ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black.withAlpha(1), // 반투명 배경
                ),
                child: Center(
                  child: RotatingHouseIndicator(),
                ),
              ),
            ),
        ],
      );
    }
  }