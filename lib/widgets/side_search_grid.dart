import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import 'custom_dropdown.dart';


class SideSearchGrid extends StatefulWidget {
  final List<String> searchConditionList;
  final TextEditingController searchWord;
  final List<Widget> gridItemList;
  final Function(String) onSearchChanged;
  final VoidCallback onSearchPressed;
  final String? hintText;
  final double? searchConditionListWidth;

  const SideSearchGrid({
    super.key,
    required this.searchWord,
    required this.gridItemList,
    required this.searchConditionList,
    required this.onSearchChanged,
    required this.onSearchPressed,
    this.hintText,
    this.searchConditionListWidth,
  });

  @override
  State<SideSearchGrid> createState() => _SideSearchGridState();
}

class _SideSearchGridState extends State<SideSearchGrid> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.searchConditionList.length == 1
                  ? SizedBox.shrink()
                  : Row(
                children: [
                  SizedBox(
                    width: widget.searchConditionListWidth ?? 136,
                    child: CustomDropdown(
                      items: widget.searchConditionList,
                      onChanged: widget.onSearchChanged,
                    ),
                  ),
                  SizedBox(width: 24),
                ],
              ),
              Expanded(
                child: TextField(
                  controller: widget.searchWord,
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? "예) 판교역로 166, 분당 주공, 백현동 532",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.color5,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: widget.onSearchPressed,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: widget.gridItemList.length,
              itemBuilder: (context, index) {
                return widget.gridItemList[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
