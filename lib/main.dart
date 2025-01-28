import 'package:flutter/material.dart';
import 'package:property_service_web/views/auth/mobile_view.dart';
import 'package:provider/provider.dart';
import 'viewmodels/login_view_model.dart';
import 'views/auth/login_view.dart';
import 'dart:html' as html;

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

  bool isMobileBrowser() {
    final userAgent = html.window.navigator.userAgent.toLowerCase();
    return userAgent.contains('mobile') ||
        userAgent.contains('android') ||
        userAgent.contains('iphone') ||
        userAgent.contains('ipad');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Property Service",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // 모든 Scaffold에 흰 배경 설정
        fontFamily: 'NotoSansKR', // pubspec.yaml에 정의한 family 이름 사용
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          displaySmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
      ),
      // home: LoginView(),
      home: isMobileBrowser() ? MobileView() : LoginView(),
    );
  }
}


