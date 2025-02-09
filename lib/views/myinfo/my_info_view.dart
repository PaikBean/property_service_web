import 'package:flutter/material.dart';
import 'package:property_service_web/core/enums/button_type.dart';
import 'package:property_service_web/core/utils/dialog_utils.dart';
import 'package:property_service_web/core/utils/toast_manager.dart';
import 'package:property_service_web/widgets/custom_text_field.dart';
import 'package:property_service_web/widgets/sub_layout.dart';

import '../../core/constants/app_colors.dart';
import '../../core/enums/main_screen_type.dart';
import '../../widgets/rotating_house_indicator.dart';

class MyInfoView extends StatefulWidget {
  const MyInfoView({super.key});

  @override
  State<MyInfoView> createState() => _MyInfoViewState();
}

class _MyInfoViewState extends State<MyInfoView> {
  bool _isLoading = false;

  void resetPassword() async {
    bool? result = await DialogUtils.showCustomDialog(context: context, title: "비밀번호 변경", child: Column(
      children: [
        CustomTextField(label: "비밀번호", controller: TextEditingController(), obscureText: true,),
        CustomTextField(label: "비밀번호 확인", controller: TextEditingController(), obscureText: true,),
      ],
    ), onConfirm: () async {
      Navigator.pop(context);
    });

    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
    ToastManager().showToast(context, "비밀번호가 변경되었습늬다.");
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SubLayout(
            mainScreenType: MainScreenType.MyInfo,
            buttonTypeList: [ButtonType.update],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Row(
                          children: [
                            Text(
                              "이름",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "홍길동",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 64),
                      SizedBox(
                        width: 240,
                        child: Row(
                          children: [
                            Text(
                              "이름",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "이메일",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 64),
                  SizedBox(
                    width: 240,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.color5, // 버튼 배경색 초록색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 둥근 테두리
                          side: BorderSide(color: AppColors.color5),
                        ),
                      ),
                      onPressed: (){
                        resetPassword();
                      },
                      child: Text(
                        "비밀번호 변경",
                        style: TextStyle(
                          fontSize: 16, // 텍스트 크기 키우기
                          fontWeight: FontWeight.w400, // 텍스트 두껍게
                          color: Colors.white, // 텍스트 색상 흰색
                        ),
                      ),
                    ),
                  )
                ],
              ),
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
}
