import 'package:flutter/material.dart';
import 'package:property_service_web/core/enums/main_screen_type.dart';
import 'package:property_service_web/core/utils/toast_manager.dart';
import 'package:property_service_web/models/image_file_list_model.dart';
import 'package:property_service_web/widgets/custom_address_field.dart';
import 'package:property_service_web/widgets/custom_radio_group.dart';
import 'package:property_service_web/widgets/custom_text_field.dart';
import 'package:property_service_web/widgets/photo_upload.dart';
import 'package:property_service_web/widgets/sub_layout.dart';

import '../../core/enums/button_type.dart';
import '../../core/utils/dialog_utils.dart';
import '../../widgets/rotating_house_indicator.dart';

class SalesBuildingRegisterView extends StatefulWidget {
  const SalesBuildingRegisterView({super.key});

  @override
  State<SalesBuildingRegisterView> createState() => _SalesBuildingRegisterViewState();
}

class _SalesBuildingRegisterViewState extends State<SalesBuildingRegisterView> {
  bool _isLoading = false;

  TextEditingController buildingName = TextEditingController();
  String? zipCode;
  String? address;
  TextEditingController parkingSpacesController = TextEditingController();
  TextEditingController floorsController = TextEditingController();
  TextEditingController gatePasswordController = TextEditingController();
  TextEditingController directionController = TextEditingController();
  TextEditingController constructionYear = TextEditingController();
  TextEditingController remark = TextEditingController();

  String? buildingUsage;
  String? elevatorAvailable;
  String? violationStatus;
  String? mainPassword;

  ImageFileListModel buildingImageList = ImageFileListModel(imageFileModelList: []);

  void _submitForm() async {
    validateInput();
    setState(() {
      _isLoading = true; // 로딩 시작
    });
    await Future.delayed(Duration(seconds: 3)); // todo 고객 등록 api 연결
    setState(() {
      _isLoading = false; // 로딩 종료
    });

    ToastManager().showToast(context, "건물을 등록했습니다.");
    clearAllData();
  }

  void clearAllData() {
    setState(() {
      // TextEditingController 초기화 방법 변경
      buildingName.clear();
      parkingSpacesController.clear();
      floorsController.clear();
      gatePasswordController.clear();
      directionController.clear();
      constructionYear.clear();
      remark.clear();

      // nullable 변수 초기화
      zipCode = "";
      address = "";

      buildingUsage = null;
      elevatorAvailable = null;
      violationStatus = null;
      mainPassword = null;

      // 리스트 초기화
      buildingImageList = ImageFileListModel(imageFileModelList: []);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SubLayout(
          mainScreenType: MainScreenType.SalesBuildingRegister,
          buttonTypeList: [ButtonType.submit],
          onSubmitPressed: _submitForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 800,
                child: CustomTextField(label: "건물 이름", controller: buildingName,),
              ),
              SizedBox(
                width: 800,
                child: CustomAddressField(
                  label: "주소",
                  zipCode: zipCode,
                  address: address,
                  onChanged: (newZipCode, newAddress) {
                    setState(() {
                      zipCode = newZipCode;
                      address = newAddress;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 800,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: CustomTextField(label: "주차 대수", controller: parkingSpacesController, keyboardType: TextInputType.number),
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomTextField(label: "층 수", controller: floorsController, keyboardType: TextInputType.number),
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomTextField(label: "주 출입문 방향", controller: directionController),
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomTextField(label: "준공 연도", controller: constructionYear, keyboardType:TextInputType.number),
                      // child: CustomDatePicker(datePickerType: DatePickerType.year, label: "준공 연도", selectedDateTime: constructionYear),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 800,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 240,
                        child: CustomRadioGroup(
                          title: "건물 용도",
                          options: ["주거용", "비 주거용"],
                          groupValue: buildingUsage,
                          onChanged: (value) => setState(() => buildingUsage = value),
                        ),
                      ),
                      CustomRadioGroup(
                        title: "승강기 유무",
                        options: ["있음", "없음"],
                        groupValue: elevatorAvailable,
                        onChanged: (value) => setState(() => elevatorAvailable = value),
                        otherInput: "있음",
                        otherLabel: "승강기 대수",
                        otherInputTextController: TextEditingController(),
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: 800,
                child: Row(
                  children: [
                    SizedBox(
                      width: 240,
                      child: CustomRadioGroup(
                        title: "위반 건축물 여부",
                        options: ["있음", "없음"],
                        groupValue: violationStatus,
                        onChanged: (value) => setState(() => violationStatus = value),
                      ),
                    ),
                    CustomRadioGroup(
                      title: "공동 현관문 비밀번호",
                      options: ["있음", "없음"],
                      groupValue: mainPassword,
                      onChanged: (value) => setState(() => mainPassword = value),
                      otherInput: "있음",
                      otherLabel: "공동 현관문 비밀번호",
                      otherInputTextController: TextEditingController(),
                      otherInputBoxWidth: 300,
                    ),
                  ],
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
              SizedBox(
                width: 800,
                child: PhotoUpload(
                  label: "건물 사진 등록",
                  imageFileListModel: buildingImageList,
                  maxUploadCount: 3,
                  toolTipMessage: "건물 사진은 최대 3개까지 등록 가능합니다.",
                ),
              ),
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
    if (zipCode == null || address == null || zipCode!.trim().isEmpty || address!.trim().isEmpty) {
      DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "주소를 입력해주세요.");
      return false;
    }

    if (floorsController.text.trim().isEmpty || int.tryParse(floorsController.text.trim()) == null) {
      DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "층 수를 올바르게 입력해주세요.");
      return false;
    }

    if (parkingSpacesController.text.trim().isEmpty || int.tryParse(parkingSpacesController.text.trim()) == null) {
      DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "주차 대수를 올바르게 입력해주세요.");
      return false;
    }

    if (constructionYear.text.isEmpty) {
      DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "준공 연도를 입력해주세요.");
      return false;
    }

    if (buildingUsage == null) {
      DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "건물 용도를 선택해주세요.");
      return false;
    }

    if (elevatorAvailable == null) {
      DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "승강기 유무를 선택해주세요.");
      return false;
    }

    if (violationStatus == null) {
      DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "위반 건축물 여부를 선택해주세요.");
      return false;
    }

    if (mainPassword == "있음" && gatePasswordController.text.trim().isEmpty) {
      DialogUtils.showAlertDialog(context: context, title: "입력 확인", content: "공동 현관문 비밀번호를 입력해주세요.");
      return false;
    }

    return true;
  }
}
