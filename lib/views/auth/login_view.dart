import 'package:flutter/material.dart';
import 'package:property_service_web/core/utils/dialog_utils.dart';
import 'package:property_service_web/views/auth/model/office_register_request.dart';
import 'package:property_service_web/views/main/main_view.dart';
import 'package:property_service_web/widgets/custom_address_field.dart';
import 'package:property_service_web/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/login_view_model.dart';
import '../../widgets/rotating_house_indicator.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 비밀번호 찾기
  void findPassword() async {
    TextEditingController currentEmail = TextEditingController();
    await DialogUtils.showCustomDialog(
      context: context,
      title: "비밀번호 초기화",
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomTextField(label: "현재 이메일", controller: currentEmail),
      ),
      confirmText: "인증 메일 전송",
      onConfirm: () async {
        Navigator.pop(context);
      }
    );

    bool isEmailMatch = false;

    if (currentEmail.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(Duration(seconds: 1)); // 비밀번호 찾기 API 호출
      isEmailMatch = DateTime.now().second % 2 == 0;
      setState(() {
        _isLoading = false;
      });
    }

    if (isEmailMatch) {
      await DialogUtils.showAlertDialog(
        context: context,
        title: "인증 완료",
        content: "등록된 이메일로 초기화된 비밀번호를 전송했습니다.\n로그인 후 비밀번호를 변경해 주세요.",
      );
    } else {
      // 인증 실패 다이얼로그를 async로 실행
      await DialogUtils.showAlertDialog(
        context: context,
        title: "인증 실패",
        content: "입력한 이메일로 등록된 계정이 없습니다.",
      );
    }
  }

  // 로그인
  void signIn() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1)); // 비밀번호 찾기 API 호출

    setState(() {
      _isLoading = false;
    });
    if(DateTime.now().second % 2 == 0){
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (
              BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              ) {
            return MainView(); // 변경 필요
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else{
      DialogUtils.showAlertDialog(context: context, title: "로그인 오류", content: "로그인 정보가 틀렸습니다.");
    }
  }

  // 사업소 등록
  void registerOffice() async {
    TextEditingController officeName = TextEditingController();
    String? zoneCode;
    String? officeAddress;
    TextEditingController addressDetail = TextEditingController();
    TextEditingController presidentName = TextEditingController();
    TextEditingController presidentEmail = TextEditingController();
    TextEditingController mobileNumber = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();

    OfficeRegisterRequest? officeRegisterRequest = await DialogUtils.showCustomDialog(
        context: context,
        maxWidth: 800,
        title: "중개 사업소 가입",
        child: Column(
          children: [
            CustomTextField(label: "중개 사업소 명", controller: officeName),
            CustomAddressField(
              label: "중개 사업소 주소",
              zipCode: zoneCode,
              address: officeAddress,
              onChanged: (newZoneCode, newOfficeAddress) {
                zoneCode = newZoneCode;
                officeAddress = newOfficeAddress;
              },
            ),
            CustomTextField(label: "중개 사업소 상세 주소", controller: addressDetail),
            CustomTextField(label: "사업소 전화번호", controller: phoneNumber),
            CustomTextField(label: "대표자 명", controller: presidentName),
            CustomTextField(label: "대표자 이메일", controller: presidentEmail),
            CustomTextField(label: "대표자 전화번호", controller: mobileNumber),
          ],
        ),
        confirmText: "가입 신청",
      onConfirm: () async {
        String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
        
        // 🚨 필수 필드 검증 (else if로 연결)
        if (officeName.text.isEmpty) {
          await DialogUtils.showAlertDialog(
            context: context,
            title: "입력 오류",
            content: "중개 사업소 명을 입력해주세요.",
          );
        } else if (zoneCode == null || officeAddress == null) {
          await DialogUtils.showAlertDialog(
            context: context,
            title: "입력 오류",
            content: "중개 사업소 주소를 입력해주세요.",
          );
        } else if (phoneNumber.text.isEmpty) {
          await DialogUtils.showAlertDialog(
            context: context,
            title: "입력 오류",
            content: "유효한 사업소 전화번호를 입력해주세요. (9~11자리 숫자)",
          );
        } else if (presidentName.text.isEmpty) {
          await DialogUtils.showAlertDialog(
            context: context,
            title: "입력 오류",
            content: "대표자 명을 입력해주세요.",
          );
        } else if (presidentEmail.text.isEmpty || !RegExp(emailPattern).hasMatch(presidentEmail.text)) {
          await DialogUtils.showAlertDialog(
            context: context,
            title: "입력 오류",
            content: "유효한 이메일 주소를 입력해주세요.",
          );
        } else if (mobileNumber.text.isEmpty) {
          await DialogUtils.showAlertDialog(
            context: context,
            title: "입력 오류",
            content: "유효한 대표자 전화번호를 입력해주세요. (9~11자리 숫자)",
          );
        } else {
          // 🚀 모든 검증을 통과하면 데이터 전송
          Navigator.pop(
            context,
            OfficeRegisterRequest(
              officeName: officeName.text,
              zoneCode: zoneCode!,
              officeAddress: officeAddress!,
              addressDetail: addressDetail.text,
              phoneNumber: phoneNumber.text,
              presidentName: presidentName.text,
              presidentEmail: presidentEmail.text,
              mobileNumber: mobileNumber.text,
            ),
          );
        }
      },
    );

    if(officeRegisterRequest != null){
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(Duration(seconds: 1)); // 비밀번호 찾기 API 호출

      setState(() {
        _isLoading = false;
      });

      DialogUtils.showAlertDialog(context: context, title: "중개 사업소 등록 완료", content: "등록하신 이메일로 코드를 발급해드렸습니다.\n회원가입을 진행해 주세요.");
    }

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final loginViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/silhouette-skyline-illustration/78786.jpg'), // 이미지 경로
                fit: BoxFit.cover, // 이미지 맞춤 옵션
              ),
            ),
          ),
          // 로그인 폼을 오른쪽으로 정렬
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Image Designed by rawpixel.com / Freepik',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Spacer(), // 왼쪽 빈 공간
              Container(
                color: Colors.white,
                width: 440,
                height: size.height,
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Property Service",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 48),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: "이메일"),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: "비밀번호"),
                          obscureText: true,
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                findPassword();
                              },
                              child: Text("비밀번호 찾기"),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            signIn();
                          },
                          child: Text("로그인"),
                        ),
                        SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                registerOffice();
                              },
                              child: Text("조직 등록"),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text("조직원 등록"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
      ),
    );
  }
}
