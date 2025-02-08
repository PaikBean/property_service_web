import 'package:flutter/material.dart';
import 'package:property_service_web/models/revenue_item_model.dart';

class RevenueGrid extends StatelessWidget {
  final List<RevenueItemModel> revenueList;
  final Function(int id) onDelete;

  const RevenueGrid({
    super.key,
    required this.revenueList,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 헤더
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "총 조회 건수",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "${revenueList.length} ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    "건",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "총 조회 매출",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "24,400,000 ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    "원",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            color: Colors.grey.shade300,
            child: Row(
              children: [
                Expanded(flex: 1, child: Center(child: Text("담당자", style: _headerStyle))),
                Expanded(flex: 1, child: Center(child: Text("고객", style: _headerStyle))),
                Expanded(flex: 1, child: Center(child: Text("유입경로", style: _headerStyle))),
                Expanded(flex: 1, child: Center(child: Text("임대인", style: _headerStyle))),
                Expanded(flex: 3, child: Center(child: Text("주소", style: _headerStyle))),
                Expanded(flex: 1, child: Center(child: Text("매물 거래 유형", style: _headerStyle))),
                Expanded(flex: 1, child: Center(child: Text("매물 가격", style: _headerStyle))),
                Expanded(flex: 1, child: Center(child: Text("중개 수수료", style: _headerStyle))),
                Expanded(flex: 1, child: Center(child: Text("입주 일자", style: _headerStyle))),
                SizedBox(width: 40), // 삭제 버튼 영역
              ],
            ),
          ),

          // 매물 목록
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: revenueList.length,
                itemBuilder: (context, index) {
                  final revenue = revenueList[index];
                  return _RevenueRow(
                    revenue: revenue,
                    onDelete: onDelete,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RevenueRow extends StatefulWidget {
  final RevenueItemModel revenue;
  final Function(int id) onDelete;

  const _RevenueRow({
    super.key,
    required this.revenue,
    required this.onDelete,
  });

  @override
  State<_RevenueRow> createState() => _RevenueRowState();
}

class _RevenueRowState extends State<_RevenueRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(flex: 1, child: Center(child: Text(widget.revenue.managerName))),
            Expanded(flex: 1, child: Center(child: Text(widget.revenue.clientName))),
            Expanded(flex: 1, child: Center(child: Text(widget.revenue.clientSource))),
            Expanded(flex: 1, child: Center(child: Text(widget.revenue.propertyOwnerName))),
            Expanded(flex: 3, child: Center(child: Text(widget.revenue.propertyAddress))),
            Expanded(flex: 1, child: Center(child: Text(widget.revenue.propertySellType))),
            Expanded(flex: 1, child: Center(child: Text(widget.revenue.propertySellPrice))),
            Expanded(flex: 1, child: Center(child: Text(widget.revenue.commissionFee))),
            Expanded(flex: 1, child: Center(child: Text(widget.revenue.moveInDate))),
            AnimatedOpacity(
              opacity: _isHovered ? 1.0 : 0.0,
              duration: Duration(milliseconds: 100),
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.grey),
                iconSize: 16,
                onPressed: () => widget.onDelete(widget.revenue.id),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle get _headerStyle => TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
