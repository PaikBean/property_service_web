import 'package:flutter/material.dart';

import '../../core/enums/main_screen_type.dart';

class ClientRegisterView extends StatefulWidget {
  const ClientRegisterView({super.key});

  @override
  State<ClientRegisterView> createState() => _ClientRegisterViewState();
}

class _ClientRegisterViewState extends State<ClientRegisterView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(MainScreenType.ClientRegister.name),
      ),
    );
  }
}
