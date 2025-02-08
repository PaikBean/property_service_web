  import 'package:flutter/material.dart';
  import 'package:property_service_web/core/enums/gender_type.dart';
  import 'package:property_service_web/core/utils/dialog_utils.dart';
  import 'package:property_service_web/core/utils/format_utils.dart';
  import 'package:property_service_web/views/client/models/client_register_model.dart';

  import '../../core/enums/button_type.dart';
  import '../../core/enums/datepicker_type.dart';
  import '../../core/enums/main_screen_type.dart';
  import '../../core/enums/transaction_type.dart';
  import '../../widgets/custom_datepicker.dart';
  import '../../widgets/custom_enum_check_box_group.dart';
  import '../../widgets/custom_enum_radio_group.dart';
  import '../../widgets/custom_text_field.dart';
  import '../../widgets/rotating_house_indicator.dart';
import '../../widgets/sub_layout.dart';
  import 'enums/client_source_type.dart';
  import 'enums/client_type_code.dart';

  class ClientRegisterView extends StatefulWidget {
    const ClientRegisterView({super.key});

    @override
    State<ClientRegisterView> createState() => _ClientRegisterViewState();
  }

  class _ClientRegisterViewState extends State<ClientRegisterView> {
    TextEditingController clientName = TextEditingController();
    TextEditingController clientPhoneNumber = TextEditingController();
    GenderType? clientGender;
    ClientType? clientType;
    TextEditingController clientTypeOther = TextEditingController();
    ClientSource? clientSource;
    TextEditingController clientSourceOther = TextEditingController();
    DateTime? clientExpectedMoveInDate;
    List<TransactionType> clientExpectedTradeTypeList = [];
    TextEditingController clientRemark = TextEditingController();

    bool _isLoading = false;

    void onSubmit() async {
      validateInput();
      var request = ClientRegisterModel(
          clientName: clientName.text,
          clientPhoneNumber: FormatUtils.formatPhoneNumber(
              clientPhoneNumber.text),
          clientGender: clientGender!,
          clientType: clientType!,
          clientTypeOther: clientTypeOther.text,
          clientSource: clientSource!,
          clientSourceOther: clientSourceOther.text,
          clientExpectedMoveInDate: clientExpectedMoveInDate!,
          clientExpectedTradeTypeList: clientExpectedTradeTypeList,
          clientRemark: clientRemark.text);

      if(await DialogUtils.showConfirmDialog(
          context: context,
          title: "고객 정보 등록",
          content: "${request.clientName} 고객님을 등록하시겠습니까?")){
        if(request.clientName.startsWith("TEMP")){
          await DialogUtils.showAlertDialog(
              context: context,
              title: "샘플 데이터 저장 시도",
              content: "샘플 데이터는 저장할 수 없습니다.");
          clearAllData();
          return;
        }

        // todo 고객 등록 api 연결
        setState(() {
          _isLoading = true; // 로딩 시작
        });

        await Future.delayed(Duration(seconds: 3)); // todo 고객 등록 api 연결
        clearAllData();
        setState(() {
          _isLoading = false; // 로딩 종료
        });
      }
    }

    void clearAllData() {
      setState(() {
        // TextEditingController 초기화
        clientName.text = "";
        clientPhoneNumber.text = "";
        clientTypeOther.text = "";
        clientSourceOther.text = "";
        clientRemark.text = "";

        // nullable 타입 초기화
        clientGender = null;
        clientType = null;
        clientSource = null;
        clientExpectedMoveInDate = null;

        // 리스트 초기화
        clientExpectedTradeTypeList.clear();
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
                      CustomEnumRadioGroup<GenderType>(
                        title: "고객 성별",
                        options: GenderType.values, // Enum 리스트를 전달
                        groupValue: clientGender,
                        onChanged: (value) =>
                            setState(() {
                              clientGender = value;
                            }),
                      ),
                      SizedBox(width: 32),
                      CustomEnumRadioGroup<ClientType>(
                        title: "고객 유형",
                        options: ClientType.values,
                        // Enum 리스트를 전달
                        groupValue: clientType,
                        onChanged: (value) =>
                            setState(() {
                              clientType = value;
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
                          clientSource = value;
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
                        clientExpectedMoveInDate = date;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 800,
                  child: CustomTextField(
                    label: "특이사항",
                    controller: TextEditingController(),
                    maxLines: 4,
                  ),
                ),
                TextButton(onPressed: (){
                  setState(() {
                    clientName.text = "TEMP_홍길동";
                    clientPhoneNumber.text = "TEMP_010-1234-5678";
                    clientGender = GenderType.male;
                    clientType = ClientType.worker;
                    clientTypeOther.text = "TEMP_기타사유";
                    clientSource = ClientSource.walking;
                    clientSourceOther.text = "TEMP_기타경로";
                    clientExpectedMoveInDate = DateTime.now().add(const Duration(days: 30));
                    clientExpectedTradeTypeList = [TransactionType.monthly, TransactionType.jeonse];
                    clientRemark.text = "TEMP_테스트 데이터입니다.";
                  });
                }, child: Text("생플 데이터 세팅")),
              ],
            ),
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

    bool validateInput() {
      if (clientName.text.trim().isEmpty) {
        DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "고객 성함을 입력해주세요.");
        return false;
      }

      if (clientPhoneNumber.text
          .trim()
          .isEmpty) {
        DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "고객 전화번호를 입력해주세요.");
        return false;
      }

      if (clientGender == null) {
        DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "고객 성별을 선택해주세요.");
        return false;
      }

      if (clientType == null) {
        DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "고객유형을 선택해주세요.");
        return false;
      }

      if (clientSource == null) {
        DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "고객 유입 경로를 선택해주세요.");
        return false;
      }

      if (clientExpectedTradeTypeList.isEmpty) {
        DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "거래 유형을 최소 하나 이상 선택해주세요.");
        return false;
      }

      if (clientExpectedMoveInDate == null) {
        DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "입주 예정일을 선택해주세요.");
        return false;
      }

      // 특이사항은 빈 값 허용이므로 검증하지 않음
      return true;
    }

    void showValidationError(String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(message),
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }