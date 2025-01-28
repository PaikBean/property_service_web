import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ScrollController horizontalController = ScrollController();
    final ScrollController verticalController = ScrollController();
    return Scaffold(
      body: SingleChildScrollView(
        controller: verticalController,
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          controller: horizontalController,
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 1440,
            height: 900,
            child: child,
          ),
        ),
      ),
    );
  }
}