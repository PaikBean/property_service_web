import 'package:flutter/material.dart';
import 'package:property_service_web/models/property_item_model.dart';

class PropertyGrid extends StatelessWidget {
  final List<PropertyItemModel> propertyItemList;
  final Function(int id) onDelete;

  const PropertyGrid({
    super.key,
    required this.propertyItemList,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 헤더
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            color: Colors.grey.shade300,
            child: Row(
              children: [
                Expanded(flex: 1, child: Center(child: Text("거래유형", style: _headerStyle))),
                Expanded(flex: 1, child: Center(child: Text("가격", style: _headerStyle))),
                Expanded(flex: 4, child: Center(child: Text("주소", style: _headerStyle))),
                Expanded(flex: 1, child: Center(child: Text("임대인", style: _headerStyle))),
                Expanded(flex: 1, child: Center(child: Text("담당자", style: _headerStyle))),
                Expanded(flex: 1, child: Center(child: Text("매물 상태", style: _headerStyle))),
                SizedBox(width: 40), // 삭제 버튼 영역
              ],
            ),
          ),

          // 매물 목록
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: propertyItemList.length,
                itemBuilder: (context, index) {
                  final property = propertyItemList[index];
                  return _PropertyRow(
                    property: property,
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

class _PropertyRow extends StatefulWidget {
  final PropertyItemModel property;
  final Function(int id) onDelete;

  const _PropertyRow({
    super.key,
    required this.property,
    required this.onDelete,
  });

  @override
  State<_PropertyRow> createState() => _PropertyRowState();
}

class _PropertyRowState extends State<_PropertyRow> {
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
            Expanded(flex: 1, child: Center(child: Text(widget.property.transactionType))),
            Expanded(flex: 1, child: Center(child: Text(widget.property.price))),
            Expanded(flex: 4, child: Center(child: Text(widget.property.address, overflow: TextOverflow.ellipsis))),
            Expanded(flex: 1, child: Center(child: Text(widget.property.propertyOwner))),
            Expanded(flex: 1, child: Center(child: Text(widget.property.propertyManager))),
            Expanded(flex: 1, child: Center(child: Text(widget.property.propertyStatus))),
            AnimatedOpacity(
              opacity: _isHovered ? 1.0 : 0.0,
              duration: Duration(milliseconds: 100),
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.grey),
                iconSize: 16,
                onPressed: () => widget.onDelete(widget.property.id),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle get _headerStyle => TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
