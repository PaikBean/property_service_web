import 'package:flutter/material.dart';

import '../../core/enums/main_screen_type.dart';

class CompanyInfoView extends StatefulWidget {
  const CompanyInfoView({super.key});

  @override
  State<CompanyInfoView> createState() => _CompanyInfoViewState();
}

class _CompanyInfoViewState extends State<CompanyInfoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(MainScreenType.CompanyInfo.name),
      ),
    );
  }
}
