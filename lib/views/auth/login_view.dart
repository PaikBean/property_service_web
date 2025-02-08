import 'package:flutter/material.dart';
import 'package:property_service_web/core/utils/dialog_utils.dart';
import 'package:property_service_web/views/main/main_view.dart';
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
      title: "비밀번호 찾기",
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomTextField(label: "현재 이메일", controller: currentEmail),
      ),
      confirmText: "인증 메일 전송",
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
      // 인증 성공
      TextEditingController newPassword = TextEditingController();
      TextEditingController newPasswordCheck = TextEditingController();

      bool isPasswordSet = false;
      while (!isPasswordSet) {
        String? result = await DialogUtils.showCustomDialog<String>(
          context: context,
          title: "비밀번호 재설정",
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(label: "비밀번호", controller: newPassword, obscureText: true),
                CustomTextField(label: "비밀번호 확인", controller: newPasswordCheck, obscureText: true),
              ],
            ),
          ),
          confirmText: "재설정",
          onConfirm: () async {
            if (newPassword.text.isEmpty || newPasswordCheck.text.isEmpty) {
              await DialogUtils.showAlertDialog(
                context: context,
                title: "오류",
                content: "모든 필드를 입력해주세요.",
              );
              return null;
            }
            if (newPassword.text != newPasswordCheck.text) {
              await DialogUtils.showAlertDialog(
                context: context,
                title: "오류",
                content: "비밀번호가 일치하지 않습니다.",
              );
              return null;
            }
            return newPassword.text; // 비밀번호가 일치하면 반환
          },
        );

        if (result != null) {
          isPasswordSet = true;
          setState(() {
            _isLoading = true;
          });
          await Future.delayed(Duration(seconds: 1)); // 비밀번호 찾기 API 호출
          setState(() {
            _isLoading = false;
          });
          DialogUtils.showAlertDialog(context: context, title: "비밀번호 변경", content: "비밀번호가 변경되었습니다. \n 다시 로그인해주세요");
        }
      }
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

  void registerOffice() async {
    TextEditingController officeNameController = TextEditingController();
    TextEditingController zoneCodeController = TextEditingController();
    TextEditingController officeAddressController = TextEditingController();
    TextEditingController presidentEmailController = TextEditingController();


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
                              onPressed: () {},
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
