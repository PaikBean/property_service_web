import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final Function(String) onChanged;
  final double dropdownHeight;

  const CustomDropdown({
    required this.items,
    required this.onChanged,
    this.dropdownHeight = 100, // 드롭다운 최대 높이
    Key? key,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode(); // 포커스 감지를 위한 노드
  final TextEditingController _controller = TextEditingController();
  bool _isDropdownOpen = false;
  late String selectedItem;

  @override
  void initState() {
    super.initState();

    // 오늘 날짜의 년도로 초기값 설정
    final int currentYear = DateTime.now().year;
    selectedItem = widget.items.contains(currentYear.toString())
        ? currentYear.toString()
        : widget.items[0]; // 현재 년도가 리스트에 있으면 설정, 없으면 첫 번째 값
    _controller.text = selectedItem;

    // 포커스 해제 시 드롭다운 닫기
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isDropdownOpen) {
        _removeDropdown();
      }
    });
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 외부 클릭 시 드롭다운 닫기
          _removeDropdown();
        },
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                offset: Offset(0.0, size.height + 5),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque, // 내부 클릭 이벤트 전달
                  onTap: () {}, // 내부 클릭은 이벤트를 차단하지 않음
                  child: Material(
                    color: Colors.transparent,
                    elevation: 4.0,
                    child: Container(
                      height: widget.dropdownHeight, // 드롭다운 최대 높이 설정
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: widget.items.length,
                          itemBuilder: (context, index) {
                            return _buildDropdownItem(widget.items[index]);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownItem(String item) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedItem = item;
        });
        _controller.text = item;
        widget.onChanged(item);
        _removeDropdown();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            item,
            style: TextStyle(
              fontSize: 16,
              fontWeight: selectedItem == item ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        readOnly: true,
        onTap: _toggleDropdown,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: _isDropdownOpen ? AppColors.color5 : Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.color5,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
