import 'package:flutter/material.dart';

import '../../core/enums/main_screen_type.dart';

class RevenueRegisterView extends StatefulWidget {
  const RevenueRegisterView({super.key});

  @override
  State<RevenueRegisterView> createState() => _RevenueRegisterViewState();
}

class _RevenueRegisterViewState extends State<RevenueRegisterView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(MainScreenType.RevenueRegsiter.name),
      ),
    );
  }
}
