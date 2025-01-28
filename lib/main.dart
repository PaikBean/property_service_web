import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/login_view_model.dart';
import 'views/auth/login_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // 모든 Scaffold에 흰 배경 설정
      ),
      // home: LoginView(),
      home: LoginView(),
    );
  }
}


