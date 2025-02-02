import 'package:flutter/material.dart';
import 'package:property_service_web/models/client_schedule_item_model.dart';
import 'package:property_service_web/models/remark_model.dart';

import '../core/constants/app_colors.dart';

class ClientScheduleGrid extends StatelessWidget {
  final List<ClientScheduleItemModel> clientScheduleItemList;
  final Function(int id) onDelete;
  final Function onAddRemark; // 특이사항 추가 콜백

  const ClientScheduleGrid({
    super.key,
    required this.clientScheduleItemList,
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
                    "담당자",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "일시",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "고객",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "일정 유형",
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
              itemCount: clientScheduleItemList.length,
              itemBuilder: (context, index) {
                final item = clientScheduleItemList[index];
                return _ScheduleRow(
                  id: item.id,
                  scheduleManager: item.scheduleManager,
                  scheduleDateTime: item.scheduleDateTime,
                  clientName: item.clientName,
                  scheduleType: item.scheduleType,
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

class _ScheduleRow extends StatefulWidget {
  final int id;
  final String scheduleManager;
  final String scheduleDateTime;
  final String clientName;
  final String scheduleType;
  final Function(int id) onDelete;

  const _ScheduleRow({
    super.key,
    required this.id,
    required this.scheduleManager,
    required this.scheduleDateTime,
    required this.clientName,
    required this.scheduleType,
    required this.onDelete,
  });

  @override
  State<_ScheduleRow> createState() => _ScheduleRowState();
}

class _ScheduleRowState extends State<_ScheduleRow> {
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
                  widget.scheduleManager,
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  widget.scheduleDateTime,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  widget.clientName,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  widget.scheduleType,
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
