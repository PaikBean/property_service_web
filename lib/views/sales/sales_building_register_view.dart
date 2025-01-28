import 'package:flutter/material.dart';

import '../../core/enums/main_screen_type.dart';

class SalesBuildingRegisterView extends StatefulWidget {
  const SalesBuildingRegisterView({super.key});

  @override
  State<SalesBuildingRegisterView> createState() => _SalesBuildingRegisterViewState();
}

class _SalesBuildingRegisterViewState extends State<SalesBuildingRegisterView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(MainScreenType.SalesBuildingRegister.name),
      ),
    );
  }
}
