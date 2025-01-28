import 'package:flutter/material.dart';
import 'package:property_service_web/views/main/main_view.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/login_view_model.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                              onPressed: () {},
                              child: Text("비밀번호 찾기"),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
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
        ],
      ),
    );
  }
}
