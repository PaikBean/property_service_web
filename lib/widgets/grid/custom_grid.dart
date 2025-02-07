import 'package:flutter/material.dart';
import 'package:property_service_web/widgets/grid/custom_grid_model.dart';

import '../../core/constants/app_colors.dart';

class ReusableGrid extends StatefulWidget {
  final String title;
  final List<CustomGridModel> columns;
  final List<Widget> itemList;
  final double contentGridHeight;
  final bool isToggle;
  final bool canDelete;
  final void Function()? onPressAdd;

  ReusableGrid({
    super.key,
    required this.title,
    required this.itemList,
    required this.columns,
    required this.contentGridHeight,
    required this.isToggle,
    required this.canDelete,
    this.onPressAdd,
  });

  @override
  State<ReusableGrid> createState() => _ReusableGridState();
}

class _ReusableGridState extends State<ReusableGrid> {
  late bool isExpanded;

  @override
  void initState() {
    isExpanded = !widget.isToggle;
    super.initState();
  }

  void toggleExpand() {
    if (widget.isToggle) {
      setState(() {
        isExpanded = !isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("| ${widget.title}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            widget.onPressAdd == null
                ? SizedBox.shrink()
                : SizedBox(
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
                onPressed: () => widget.onPressAdd!(),
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
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey, // 선 색상
                width: 1.0, // 선 두께
              ),
            ),
          ),
          child: Row(
            children: [
              ...widget.columns.map((col) => Expanded(
                flex: col.flex,
                child: Center(
                  child: Text(
                    col.header,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              )),
              if (widget.canDelete) SizedBox(width: 40),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: widget.isToggle
              ? (isExpanded ? widget.contentGridHeight : 50)
              : widget.contentGridHeight,
          child: ListView.builder(
            itemCount: widget.itemList.length,
            itemBuilder: (context, index) {
              return widget.itemList[index];
            },
          ),
        ),
        if(widget.isToggle)
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: toggleExpand,
                  style: TextButton.styleFrom(
                    overlayColor: AppColors.color4,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${widget.title} ${isExpanded ? "접기" : "더보기"}",
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey[800]),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        isExpanded
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: Colors.grey[800],
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
