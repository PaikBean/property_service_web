import 'package:flutter/material.dart';
import 'package:property_service_web/models/client_schedule_item_model.dart';
import 'package:property_service_web/models/client_showing_property_model.dart';
import 'package:property_service_web/models/remark_model.dart';

import '../core/constants/app_colors.dart';

class ClientShowingPropertyGrid extends StatelessWidget {
  final List<ClientShowingPropertyModel> showingPropertyList;
  final Function(int id) onDelete;
  final Function onAddRemark; // 특이사항 추가 콜백

  const ClientShowingPropertyGrid({
    super.key,
    required this.showingPropertyList,
    required this.onDelete,
    required this.onAddRemark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 헤더
        // 상단 추가 버튼
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 40,
              height: 32, // 정사각형 버튼 크기
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.transparent), // 배경색 투명
                  elevation: WidgetStateProperty.all(0), // 그림자 제거
                  padding: WidgetStateProperty.all(EdgeInsets.zero), // 내부 여백 제거
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 둥근 테두리
                      side: BorderSide(color: AppColors.color5, width: 2), // 테두리 설정
                    ),
                  ),
                  overlayColor: WidgetStateProperty.all(Colors.transparent), // hover 효과 제거
                ),
                onPressed: () => onAddRemark(),
                child: Text(
                  "추가",
                  style: TextStyle(
                    fontSize: 14, // 텍스트 크기 키우기
                    fontWeight: FontWeight.w500, // 텍스트 두껍게
                    color: AppColors.color5,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          color: Colors.grey.shade300,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "매물 거래 유형",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "매물 가격",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "매물 형태",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    "매물 주소",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(width: 40), // 삭제 버튼 영역
            ],
          ),
        ),
        // 스크롤 가능한 ListView
        Expanded(
          child: Container(
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: showingPropertyList.length,
              itemBuilder: (context, index) {
                final item = showingPropertyList[index];
                return _ShowingPropertyRow(
                  id: item.id,
                  propertySellType: item.propertySellType,
                  propertySellAmount: item.propertySellAmount,
                  propertyAddress: item.propertyAddress,
                  propertyType: item.propertyType,
                  onDelete: onDelete,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ShowingPropertyRow extends StatefulWidget {
  final int id;
  final String propertySellType;
  final String propertySellAmount;
  final String propertyAddress;
  final String propertyType;
  final Function(int id) onDelete;

  const _ShowingPropertyRow({
    super.key,
    required this.id,
    required this.propertySellType,
    required this.propertySellAmount,
    required this.propertyAddress,
    required this.propertyType,
    required this.onDelete,
  });

  @override
  State<_ShowingPropertyRow> createState() => _ShowingPropertyRowState();
}

class _ShowingPropertyRowState extends State<_ShowingPropertyRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8), // 줄 높이 조정
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  widget.propertySellType,
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  widget.propertySellAmount,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  widget.propertyType,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  widget.propertyAddress,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _isHovered ? 1.0 : 0.0,
              duration: Duration(milliseconds: 100),
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.grey),
                iconSize: 16, // 삭제 버튼 크기 조정
                onPressed: () => widget.onDelete(widget.id),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
