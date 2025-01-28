import 'package:flutter/material.dart';

import '../../core/enums/main_screen_type.dart';

class ClientListView extends StatefulWidget {
  const ClientListView({super.key});

  @override
  State<ClientListView> createState() => _ClientListViewState();
}

class _ClientListViewState extends State<ClientListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(MainScreenType.ClientList.name),
      ),
    );
  }
}
