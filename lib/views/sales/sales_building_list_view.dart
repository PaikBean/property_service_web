import 'package:flutter/material.dart';

import '../../core/enums/main_screen_type.dart';

class SalesBuildingListView extends StatefulWidget {
  const SalesBuildingListView({super.key});

  @override
  State<SalesBuildingListView> createState() => _SalesBuildingListViewState();
}

class _SalesBuildingListViewState extends State<SalesBuildingListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Text(MainScreenType.SalesBuildingList.name),
          ),
          ElevatedButton(
            onPressed: (){},
            child: Text("매물상세로 이동"),
          ),
        ],
      ),
    );
  }
}
