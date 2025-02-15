import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:property_service_web/core/utils/dialog_utils.dart';
import 'package:property_service_web/views/auth/model/office_register_request.dart';
import 'package:property_service_web/views/auth/model/office_user_request.dart';
import 'package:property_service_web/views/main/main_view.dart';
import 'package:property_service_web/widgets/custom_address_field.dart';
import 'package:property_service_web/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../viewmodels/login_view_model.dart';
import '../../widgets/rotating_house_indicator.dart';

final Dio dio = Dio();
final storage = FlutterSecureStorage();

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

  Future<bool> login(String email, String password) async {
    try {
      final response = await dio.post(
        'http://localhost:8080/api/auth/login',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final token = response.headers['authorization']?.first;

        if (token != null) {
          await storage.write(key: 'jwt', value: token);
          return true;
        }
      }

      return false;

    } catch (e) {
      print('로그인 요청 중 오류 발생: $e');
      return false;
    }
  }


  // 로그인
  void signIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool result = await login(_emailController.text, _passwordController.text);
      if (result) {
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
      } else {
        DialogUtils.showAlertDialog(context: context, title: "로그인 오류", content: "로그인 정보가 틀렸습니다.");
      }
    } catch (e) {
      print('signIn 중 오류 발생: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  // 사무소 등록
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
        title: "중개 사무소 가입",
        child: Column(
          children: [
            CustomTextField(label: "중개 사무소 명", controller: officeName),
            CustomAddressField(
              label: "중개 사무소 주소",
              zipCode: zoneCode,
              address: officeAddress,
              onChanged: (newZoneCode, newOfficeAddress) {
                zoneCode = newZoneCode;
                officeAddress = newOfficeAddress;
              },
            ),
            CustomTextField(label: "중개 사무소 상세 주소", controller: addressDetail),
            CustomTextField(label: "중개 사무소 전화번호", controller: phoneNumber),
            CustomTextField(label: "대표자", controller: presidentName),
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
            content: "중개 사무소 명을 입력해주세요.",
          );
        } else if (zoneCode == null || officeAddress == null) {
          await DialogUtils.showAlertDialog(
            context: context,
            title: "입력 오류",
            content: "중개 사무소 주소를 입력해주세요.",
          );
        } else if (phoneNumber.text.isEmpty) {
          await DialogUtils.showAlertDialog(
            context: context,
            title: "입력 오류",
            content: "유효한 사무소 전화번호를 입력해주세요. (9~11자리 숫자)",
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

      DialogUtils.showAlertDialog(context: context, title: "중개 사무소 등록 완료", content: "등록하신 이메일로 코드를 발급해드렸습니다.\n중개 사무원 등록을 진행해 주세요.");
    }

  }

  // 중개 사무원 등록
  void signUp() async {
    TextEditingController officeCode = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController passwordCheck = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();

    OfficeUserRequest? officeUserRequest = await DialogUtils.showCustomDialog(
        context: context,
        title: "중개 사무원",
        child: Column(
          children: [
            CustomTextField(label: "소속 중개 사무소 코드", controller: officeCode),
            CustomTextField(label: "이름", controller: name),
            CustomTextField(label: "이메일", controller: email),
            CustomTextField(label: "비밀번호", controller: password, obscureText: true),
            CustomTextField(label: "비밀번호 확인", controller: passwordCheck, obscureText: true),
            CustomTextField(label: "핸드폰 번호", controller: phoneNumber),
          ],
        ),
        onConfirm: () async {
          String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

          // 🚨 필수 필드 검증 (else if로 연결)
          if (officeCode.text.isEmpty) {
            await DialogUtils.showAlertDialog(
              context: context,
              title: "입력 오류",
              content: "중개 사무소 코드를 확인해주세요.",
            );
          } else if (name.text.isEmpty) {
            await DialogUtils.showAlertDialog(
              context: context,
              title: "입력 오류",
              content: "이름을 입력해 주세요.",
            );
          } else if (email.text.isEmpty || !RegExp(emailPattern).hasMatch(email.text)) {
            await DialogUtils.showAlertDialog(
              context: context,
              title: "입력 오류",
              content: "이메일을 올바르게 입력해 주세요.",
            );
          } else if (password.text.isEmpty  || passwordCheck.text.isEmpty || passwordCheck.text == password.text) {
            await DialogUtils.showAlertDialog(
              context: context,
              title: "입력 오류",
              content: "비밀번호가 올바르게 입력되지 않았습니다.",
            );
          } else if (phoneNumber.text.isEmpty) {
            await DialogUtils.showAlertDialog(
              context: context,
              title: "입력 오류",
              content: "핸드폰번호를 입력해 주세요.",
            );
          }
          Navigator.pop(context);
        }
    );

    if(officeUserRequest != null){
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(Duration(seconds: 1)); // 비밀번호 찾기 API 호출

      setState(() {
        _isLoading = false;
      });

      DialogUtils.showAlertDialog(context: context, title: "중개 사무원 가입 완료", content: "가입이 완료되었습니다.\n로그인 해주세요.");
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
                              child: Text("중개 사무소 등록"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                signUp();
                              },
                              child: Text("중개 사무원 등록"),
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
