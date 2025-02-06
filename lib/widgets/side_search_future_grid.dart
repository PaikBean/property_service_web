import 'package:flutter/material.dart';
import 'package:property_service_web/widgets/rotating_house_indicator.dart';

import '../core/constants/app_colors.dart';
import 'custom_dropdown.dart';

class SideSearchFutureGrid extends StatefulWidget {
  final List<String> searchConditionList;
  final TextEditingController searchWord;
  final Future<List<Widget>> Function() fetchGridItems; // Future 함수 추가
  final Function(String) onSearchChanged;
  final VoidCallback onSearchPressed;
  final String? hintText;
  final double? searchConditionListWidth;

  const SideSearchFutureGrid({
    super.key,
    required this.searchWord,
    required this.fetchGridItems, // Future 함수 전달
    required this.searchConditionList,
    required this.onSearchChanged,
    required this.onSearchPressed,
    this.hintText,
    this.searchConditionListWidth,
  });

  @override
  State<SideSearchFutureGrid> createState() => _SideSearchFutureGridState();
}

class _SideSearchFutureGridState extends State<SideSearchFutureGrid> {
  late Future<List<Widget>> _gridItemsFuture;

  @override
  void initState() {
    super.initState();
    _gridItemsFuture = widget.fetchGridItems(); // 초기 로딩 시 데이터 가져오기
  }

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
                      onPressed: () {
                        setState(() {
                          _gridItemsFuture = widget.fetchGridItems(); // 검색 시 데이터 다시 불러오기
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List<Widget>>(
              future: _gridItemsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: RotatingHouseIndicator()); // 로딩 UI
                } else if (snapshot.hasError) {
                  return Center(child: Text("데이터를 불러오는 중 오류 발생")); // 에러 UI
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("검색 결과 없음")); // 결과 없음 UI
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return snapshot.data![index];
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
