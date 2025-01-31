import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:property_service_web/core/enums/main_screen_type.dart';
import 'package:property_service_web/widgets/custom_radio_group.dart';
import 'package:property_service_web/widgets/custom_text_field.dart';
import 'package:property_service_web/widgets/photo_upload.dart';
import 'package:property_service_web/widgets/sub_layout.dart';

import '../../core/enums/button_type.dart';

class SalesBuildingRegisterView extends StatefulWidget {
  const SalesBuildingRegisterView({super.key});

  @override
  State<SalesBuildingRegisterView> createState() => _SalesBuildingRegisterViewState();
}

class _SalesBuildingRegisterViewState extends State<SalesBuildingRegisterView> {

  TextEditingController buildingName = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController parkingSpacesController = TextEditingController();
  TextEditingController floorsController = TextEditingController();
  TextEditingController gatePasswordController = TextEditingController();
  TextEditingController directionController = TextEditingController();
  TextEditingController constructionYearController = TextEditingController();
  TextEditingController remark = TextEditingController();

  final List<Uint8List> buildingImageList = [];

  String? buildingUsage;
  String? elevatorAvailable;
  String? violationStatus;
  String? mainPassword;


  void _submitForm() async {
    // 폼 제출 로직
    print("폼 제출");
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      mainScreenType: MainScreenType.SalesBuildingRegister,
      buttonTypeList: [ButtonType.submit],
      onSubmitPressed: _submitForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 800,
            child: CustomTextField(label: "건물 이름", controller: buildingName),
          ),
          SizedBox(
            width: 800,
            child: CustomTextField(label: "주소", controller: addressController, readOnly: true),
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
                  child: CustomTextField(label: "준공 연도", controller: constructionYearController),    // todo 캘린더 위젯 사용
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
              onImagesSelected: (images){
                setState(() {
                  buildingImageList.clear();
                  buildingImageList.addAll(images);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
