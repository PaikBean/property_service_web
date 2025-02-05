import 'package:flutter/material.dart';
import 'package:property_service_web/core/enums/button_type.dart';
import 'package:property_service_web/widgets/sub_layout.dart';

import '../../core/constants/app_colors.dart';
import '../../core/enums/main_screen_type.dart';

class MyInfoView extends StatefulWidget {
  const MyInfoView({super.key});

  @override
  State<MyInfoView> createState() => _MyInfoViewState();
}

class _MyInfoViewState extends State<MyInfoView> {
  @override
  Widget build(BuildContext context) {
    return SubLayout(
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
                  onPressed: (){},
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
    );
  }
}
