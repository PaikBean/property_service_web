import 'package:flutter/material.dart';

import '../../core/enums/main_screen_type.dart';

class SalesPropertyDetailView extends StatefulWidget {
  const SalesPropertyDetailView({super.key});

  @override
  State<SalesPropertyDetailView> createState() => _SalesPropertyDetailViewState();
}

class _SalesPropertyDetailViewState extends State<SalesPropertyDetailView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Text(MainScreenType.SalesPropertyDetail.name),
          ),
          ElevatedButton(onPressed: (){}, child: Text("건물,임대인 목록으로 이동")),
        ],
      ),
    );
  }
}
