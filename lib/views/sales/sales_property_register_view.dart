import 'package:flutter/material.dart';

import '../../core/enums/main_screen_type.dart';

class SalesPropertyRegisterView extends StatefulWidget {
  const SalesPropertyRegisterView({super.key});

  @override
  State<SalesPropertyRegisterView> createState() => _SalesPropertyRegisterViewState();
}

class _SalesPropertyRegisterViewState extends State<SalesPropertyRegisterView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(MainScreenType.SalesPropertyRegister.name),
      ),
    );
  }
}
