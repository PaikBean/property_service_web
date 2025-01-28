import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/login_view_model.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 1240,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/silhouette-skyline-illustration/78786.jpg'), // 이미지 경로
                  fit: BoxFit.cover, // 이미지 맞춤 옵션
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  'Image Designed by rawpixel.com / Freepik',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "Property Service",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[600]
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
                        onPressed: (){},
                        child: Text("비밀번호 찾기"),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("로그인"),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: (){},
                      child: Text("조직 등록"),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      child: Text("조직원 등록"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
