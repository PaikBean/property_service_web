import 'package:flutter/material.dart';

import '../../core/enums/main_screen_type.dart';

class RevenueListView extends StatefulWidget {
  const RevenueListView({super.key});

  @override
  State<RevenueListView> createState() => _RevenueListViewState();
}

class _RevenueListViewState extends State<RevenueListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(MainScreenType.RevenueList.name),
      ),
    );
  }
}
