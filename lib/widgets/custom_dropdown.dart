import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final Function(String) onChanged;

  const CustomDropdown({required this.items, required this.onChanged, Key? key}) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _controller = TextEditingController();
  bool _isDropdownOpen = false;
  late String selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.items[0];
    _controller.text = selectedItem;
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
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0.0, size.height + 5),
          child: Material(
            color: Colors.transparent,
            elevation: 4.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.items.map((item) => _buildDropdownItem(item)).toList(),
              ),
            ),
          ),
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
