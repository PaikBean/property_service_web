import 'package:flutter/material.dart';
import 'package:property_service_web/core/enums/datepicker_type.dart';
import 'package:property_service_web/models/revenue_item_model.dart';
import 'package:property_service_web/widgets/custom_datepicker.dart';
import 'package:property_service_web/widgets/revenue_grid.dart';
import 'package:property_service_web/widgets/sub_layout.dart';

import '../../core/constants/app_colors.dart';
import '../../core/enums/main_screen_type.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_radio_group.dart';
import '../../widgets/custom_text_field.dart';

class RevenueListView extends StatefulWidget {
  const RevenueListView({super.key});

  @override
  State<RevenueListView> createState() => _RevenueListViewState();
}

class _RevenueListViewState extends State<RevenueListView> {
  TextEditingController searchWordController = TextEditingController();

  bool _isExpanded = false;

  String propertyType = "전체";
  String clientSourceType = "전체";
  String commissionFeeCondition = "전체";

  final List<String> searchConditionList = ["전체", "담당자", "고객", "주소", "임대인"];
  final List<RevenueItemModel> revenueList = [
    RevenueItemModel(id: 1, managerName: "김철수", clientName: "고객1", clientSource: "지인 추천", propertyOwnerName: "임대인1", propertyAddress: "서울특별시 강동구 풍성로99길 99 101호", propertySellType: "월세", propertySellPrice: "300/30 만 원", commissionFee: "15만원", moveInDate: "2024.01.01"),
    RevenueItemModel(id: 2, managerName: "이영희", clientName: "고객2", clientSource: "네이버 검색", propertyOwnerName: "임대인2", propertyAddress: "서울특별시 송파구 올림픽로 55", propertySellType: "전세", propertySellPrice: "2억 5000만원", commissionFee: "100만원", moveInDate: "2024.02.01"),
    RevenueItemModel(id: 3, managerName: "박민수", clientName: "고객3", clientSource: "SNS 광고", propertyOwnerName: "임대인3", propertyAddress: "서울특별시 강남구 테헤란로 120", propertySellType: "매매", propertySellPrice: "6억 8000만원", commissionFee: "340만원", moveInDate: "2024.03.01"),
    RevenueItemModel(id: 4, managerName: "최지훈", clientName: "고객4", clientSource: "유튜브 광고", propertyOwnerName: "임대인4", propertyAddress: "서울특별시 마포구 신촌로 87", propertySellType: "월세", propertySellPrice: "500/50 만 원", commissionFee: "25만원", moveInDate: "2024.04.01"),
    RevenueItemModel(id: 5, managerName: "윤서연", clientName: "고객5", clientSource: "오프라인 방문", propertyOwnerName: "임대인5", propertyAddress: "서울특별시 종로구 종로 23", propertySellType: "전세", propertySellPrice: "1억 7000만원", commissionFee: "85만원", moveInDate: "2024.05.01"),
    RevenueItemModel(id: 6, managerName: "김철수", clientName: "고객6", clientSource: "SNS 광고", propertyOwnerName: "임대인6", propertyAddress: "서울특별시 서초구 강남대로 305", propertySellType: "매매", propertySellPrice: "7억 5000만원", commissionFee: "375만원", moveInDate: "2024.06.01"),
    RevenueItemModel(id: 7, managerName: "이영희", clientName: "고객7", clientSource: "카카오톡", propertyOwnerName: "임대인7", propertyAddress: "서울특별시 노원구 동일로 999", propertySellType: "월세", propertySellPrice: "1000/70 만 원", commissionFee: "35만원", moveInDate: "2024.07.01"),
    RevenueItemModel(id: 8, managerName: "박민수", clientName: "고객8", clientSource: "지인 추천", propertyOwnerName: "임대인8", propertyAddress: "서울특별시 성동구 왕십리로 35", propertySellType: "전세", propertySellPrice: "2억 3000만원", commissionFee: "115만원", moveInDate: "2024.08.01"),
    RevenueItemModel(id: 9, managerName: "최지훈", clientName: "고객9", clientSource: "네이버 검색", propertyOwnerName: "임대인9", propertyAddress: "서울특별시 영등포구 국제금융로 10", propertySellType: "매매", propertySellPrice: "5억 2000만원", commissionFee: "260만원", moveInDate: "2024.09.01"),
    RevenueItemModel(id: 10, managerName: "윤서연", clientName: "고객10", clientSource: "오프라인 방문", propertyOwnerName: "임대인10", propertyAddress: "서울특별시 강북구 도봉로 44", propertySellType: "월세", propertySellPrice: "800/60 만 원", commissionFee: "30만원", moveInDate: "2024.10.01"),
    RevenueItemModel(id: 11, managerName: "김철수", clientName: "고객11", clientSource: "블로그", propertyOwnerName: "임대인11", propertyAddress: "서울특별시 서대문구 연세로 101", propertySellType: "전세", propertySellPrice: "3억 5000만원", commissionFee: "175만원", moveInDate: "2024.11.01"),
    RevenueItemModel(id: 12, managerName: "이영희", clientName: "고객12", clientSource: "유튜브 광고", propertyOwnerName: "임대인12", propertyAddress: "서울특별시 동작구 상도로 99", propertySellType: "매매", propertySellPrice: "4억 9000만원", commissionFee: "245만원", moveInDate: "2024.12.01"),
    RevenueItemModel(id: 13, managerName: "박민수", clientName: "고객13", clientSource: "지인 추천", propertyOwnerName: "임대인13", propertyAddress: "서울특별시 중랑구 망우로 35", propertySellType: "월세", propertySellPrice: "1200/80 만 원", commissionFee: "40만원", moveInDate: "2025.01.01"),
    RevenueItemModel(id: 14, managerName: "최지훈", clientName: "고객14", clientSource: "카카오톡", propertyOwnerName: "임대인14", propertyAddress: "서울특별시 은평구 불광로 57", propertySellType: "전세", propertySellPrice: "1억 9000만원", commissionFee: "95만원", moveInDate: "2025.02.01"),
    RevenueItemModel(id: 15, managerName: "윤서연", clientName: "고객15", clientSource: "네이버 검색", propertyOwnerName: "임대인15", propertyAddress: "서울특별시 도봉구 도봉로 88", propertySellType: "매매", propertySellPrice: "6억 2000만원", commissionFee: "310만원", moveInDate: "2025.03.01"),
    RevenueItemModel(id: 16, managerName: "김철수", clientName: "고객16", clientSource: "블로그", propertyOwnerName: "임대인16", propertyAddress: "서울특별시 광진구 능동로 12", propertySellType: "월세", propertySellPrice: "700/55 만 원", commissionFee: "27만원", moveInDate: "2025.04.01"),
    RevenueItemModel(id: 17, managerName: "이영희", clientName: "고객17", clientSource: "유튜브 광고", propertyOwnerName: "임대인17", propertyAddress: "서울특별시 금천구 가산디지털단지 102", propertySellType: "전세", propertySellPrice: "2억 1000만원", commissionFee: "105만원", moveInDate: "2025.05.01"),
    RevenueItemModel(id: 18, managerName: "박민수", clientName: "고객18", clientSource: "SNS 광고", propertyOwnerName: "임대인18", propertyAddress: "서울특별시 관악구 신림로 99", propertySellType: "매매", propertySellPrice: "5억 7000만원", commissionFee: "285만원", moveInDate: "2025.06.01"),
  ];


  @override
  Widget build(BuildContext context) {
    return SubLayout(
        mainScreenType: MainScreenType.RevenueList,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 900,
              child: Row(
                children: [
                  SizedBox(
                    width: 240,
                    child: CustomDatePicker(datePickerType: DatePickerType.dateRange, label: "검색 기간", selectedDateTime: DateTime.now()),
                  ),
                  SizedBox(
                    width: 144,
                    child: CustomDropdown(
                      items: searchConditionList,
                      onChanged: (_){},
                    ),
                  ),
                  Container(
                    width : 248,
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: searchWordController,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.color5,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.color5, // 버튼 배경색 초록색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 둥근 테두리
                          side: BorderSide(color: AppColors.color5),
                        ),
                      ),
                      onPressed: (){},
                      child: Text(
                        "조회",
                        style: TextStyle(
                          fontSize: 16, // 텍스트 크기 키우기
                          fontWeight: FontWeight.w400, // 텍스트 두껍게
                          color: Colors.white, // 텍스트 색상 흰색
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    height: 48,
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded; // 상태 변경
                          });
                        },
                        style: TextButton.styleFrom(
                          overlayColor: AppColors.color4,
                        ),
                        child: Row(
                          children: [
                            Text(
                              _isExpanded ? "검색 상세 조건" : "검색 상세 조건",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[800]),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              _isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: Colors.grey[800],
                              size: 20,
                            ),
                          ],
                        ),
                    ),
                  ),
                ],
              ),
            ),
            if(_isExpanded)
              Row(
                children: [
                  SizedBox(
                    width: 440,
                    child: CustomRadioGroup(
                      title: "거래 유형",
                      options: ["전체", "월세", "전세", "단기"],
                      groupValue: propertyType,
                      onChanged: (value) =>
                          setState(() => propertyType = value!),
                    ),
                  ),
                  SizedBox(
                    width: 440,
                    child: CustomRadioGroup(
                      title: "고객 유입 경로",
                      options: ["전체", "피터팬", "직방", "다방", "기타"],
                      groupValue: clientSourceType,
                      onChanged: (value) =>
                          setState(() => clientSourceType = value!),
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 720,
              width: 1420,
              child: RevenueGrid(
                  revenueList: revenueList,
                  onDelete: (_){}
              ),
            )
          ],
        )
    );
  }
}
