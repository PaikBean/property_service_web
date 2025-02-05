import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:property_service_web/core/enums/button_type.dart';
import 'package:property_service_web/models/client_schedule_item_model.dart';
import 'package:property_service_web/models/client_showing_property_model.dart';
import 'package:property_service_web/models/client_summary_model.dart';
import 'package:property_service_web/widgets/client_schedule_grid.dart';
import 'package:property_service_web/widgets/client_showing_property_grid.dart';
import 'package:property_service_web/widgets/sub_layout.dart';
import 'package:property_service_web/widgets/sub_title.dart';

import '../../core/enums/main_screen_type.dart';
import '../../models/remark_model.dart';
import '../../widgets/remark_grid.dart';
import '../../widgets/side_search_grid.dart';

class ClientListView extends StatefulWidget {
  const ClientListView({super.key});

  @override
  State<ClientListView> createState() => _ClientListViewState();
}

class _ClientListViewState extends State<ClientListView> {
  TextEditingController clientSearchWord = TextEditingController();

  late List<String> searchConditionList;
  late List<ClientSummaryModel> clientSummaryModelList;
  late List<Widget> gridItemList;

  final List<RemarkModel> remarkModelList = [
    RemarkModel(
        id: 1,
        remark: "특이사항1",
        createdDate: "2024-01-01 13:00",
        createdUserId: 1,
        createdUserName: "김철수"),
    RemarkModel(
        id: 2,
        remark: "특이사항2",
        createdDate: "2024-01-01 13:00",
        createdUserId: 1,
        createdUserName: "홍길동"),
    RemarkModel(
        id: 3,
        remark: "특이사항3",
        createdDate: "2024-01-01 13:00",
        createdUserId: 1,
        createdUserName: "김미애"),
    RemarkModel(
        id: 4,
        remark: "특이사항4",
        createdDate: "2024-01-01 13:00",
        createdUserId: 1,
        createdUserName: "김군"),
    RemarkModel(
        id: 5,
        remark: "특이사항5",
        createdDate: "2024-01-01 13:00",
        createdUserId: 1,
        createdUserName: "임상"),
    RemarkModel(
        id: 6,
        remark: "특이사항6",
        createdDate: "2024-01-01 13:00",
        createdUserId: 1,
        createdUserName: "김철수"),
  ];
  final List<ClientScheduleItemModel> clientScheduleModelList = [
    ClientScheduleItemModel(id: 1, scheduleManager: "김철수", scheduleDateTime: "2025.01.01 13:00", clientName: "홍길동", scheduleType: "상담"),
    ClientScheduleItemModel(id: 2, scheduleManager: "김철수", scheduleDateTime: "2025.01.02 13:00", clientName: "홍길동", scheduleType: "상담"),
    ClientScheduleItemModel(id: 3, scheduleManager: "김철수", scheduleDateTime: "2025.01.03 13:00", clientName: "홍길동", scheduleType: "상담"),
    ClientScheduleItemModel(id: 4, scheduleManager: "김철수", scheduleDateTime: "2025.01.04 13:00", clientName: "홍길동", scheduleType: "계약"),
    ClientScheduleItemModel(id: 5, scheduleManager: "김철수", scheduleDateTime: "2025.01.05 13:00", clientName: "홍길동", scheduleType: "상담"),
    ClientScheduleItemModel(id: 6, scheduleManager: "김철수", scheduleDateTime: "2025.01.06 13:00", clientName: "홍길동", scheduleType: "입주"),
    ClientScheduleItemModel(id: 7, scheduleManager: "김철수", scheduleDateTime: "2025.01.07 13:00", clientName: "홍길동", scheduleType: "입주"),
    ClientScheduleItemModel(id: 8, scheduleManager: "김철수", scheduleDateTime: "2025.01.08 13:00", clientName: "홍길동", scheduleType: "입주 완료"),
  ];
  final List<ClientShowingPropertyModel> showingPropertyList = [
    ClientShowingPropertyModel(id: 1, propertySellType: "월세", propertySellAmount: "300/30 만원", propertyAddress: "서울특별시 강동구 둔촌동 123-3 101호", propertyType: "원룸"),
    ClientShowingPropertyModel(id: 2, propertySellType: "전세", propertySellAmount: "1억 5000만원", propertyAddress: "서울특별시 송파구 잠실동 45-2 301호", propertyType: "아파트"),
    ClientShowingPropertyModel(id: 3, propertySellType: "매매", propertySellAmount: "5억 2000만원", propertyAddress: "서울특별시 서초구 반포동 55-12", propertyType: "오피스텔"),
    ClientShowingPropertyModel(id: 4, propertySellType: "월세", propertySellAmount: "1000/50 만원", propertyAddress: "서울특별시 마포구 상수동 23-8 201호", propertyType: "빌라"),
    ClientShowingPropertyModel(id: 5, propertySellType: "전세", propertySellAmount: "2억 8000만원", propertyAddress: "서울특별시 강남구 역삼동 88-6 401호", propertyType: "아파트"),
    ClientShowingPropertyModel(id: 6, propertySellType: "매매", propertySellAmount: "8억 7000만원", propertyAddress: "서울특별시 용산구 한남동 14-3", propertyType: "단독주택"),
  ];


  @override
  void initState() {
    // TODO: implement initState
    searchConditionList = [
      "담당자",
      "고객 성함",
      "고객 전화번호",
    ];
    clientSummaryModelList = [
      ClientSummaryModel(id: 1, clientName: "홍길동", clientPhoneNumber: "010-1234-1234", clientManger: "담당자1", clientResource: "피터팬"),
      ClientSummaryModel(id: 2, clientName: "이순신", clientPhoneNumber: "010-5678-5678", clientManger: "담당자2", clientResource: "광고"),
      ClientSummaryModel(id: 3, clientName: "강감찬", clientPhoneNumber: "010-8765-4321", clientManger: "담당자1", clientResource: "SNS"),
      ClientSummaryModel(id: 4, clientName: "유관순", clientPhoneNumber: "010-1111-2222", clientManger: "담당자3", clientResource: "지인추천"),
      ClientSummaryModel(id: 5, clientName: "안중근", clientPhoneNumber: "010-3333-4444", clientManger: "담당자2", clientResource: "네이버 검색"),
      ClientSummaryModel(id: 6, clientName: "김유신", clientPhoneNumber: "010-5555-6666", clientManger: "담당자4", clientResource: "유튜브 광고"),
      ClientSummaryModel(id: 7, clientName: "정약용", clientPhoneNumber: "010-7777-8888", clientManger: "담당자3", clientResource: "페이스북"),
      ClientSummaryModel(id: 8, clientName: "세종대왕", clientPhoneNumber: "010-9999-0000", clientManger: "담당자5", clientResource: "카카오톡"),
      ClientSummaryModel(id: 9, clientName: "장보고", clientPhoneNumber: "010-1212-3434", clientManger: "담당자2", clientResource: "오프라인 방문"),
      ClientSummaryModel(id: 10, clientName: "최무선", clientPhoneNumber: "010-4545-5656", clientManger: "담당자4", clientResource: "블로그"),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      mainScreenType: MainScreenType.ClientList,
      buttonTypeList: [ButtonType.update],
      onUpdatePressed: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 400,
            height: 800,
            child: SideSearchGrid(
              searchWord: clientSearchWord,
              gridItemList: clientSummaryModelList
                  .map((property) => _buildClientItem(property))
                  .toList(),
              searchConditionList: searchConditionList,
              onSearchChanged: (_) {},
              onSearchPressed: () {},
              hintText: "",
              searchConditionListWidth: 156,
            ),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubTitle(title: "고객 상세"),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 600,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          "고객 성함",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "홍길동",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 64),
                        Text(
                          "고객 전화번호",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "010 - 1234 - 1234",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "고객 상태",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "입주 완료",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 80),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: 800,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      "유입경로",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "피터팬",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 64),
                    Text(
                      "고객 성별",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "남성",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 64),
                    Text(
                      "고객 유형",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "직장인",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 64),
                    Text(
                      "입주 예정일",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "2025-01-01",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 800,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                  ],
                ),
              ),
              Container(
                width: 960,
                height: 256,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ClientScheduleGrid(
                  clientScheduleItemList: clientScheduleModelList,
                  onDelete: (id) {
                    print(id);
                  },
                  onAddRemark: () {},
                  showLabel: true
                ),
              ),
              Container(
                width: 960,
                height: 256,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ClientShowingPropertyGrid(
                  showingPropertyList: showingPropertyList,
                  onDelete: (id) {
                    print(id);
                  },
                  onAddRemark: () {},
                  showLabel: true,
                ),
              ),
              Container(
                width: 960,
                height: 256,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: RemarkGrid(
                  remarkModel: remarkModelList,
                  onDelete: (id) {
                    print(id);
                  },
                  onAddRemark: () {},
                  showLabel: true,
                  isColab: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClientItem(ClientSummaryModel clientSummaryModel) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white),
      child: Row(
        children: [
          SizedBox(
              width: 100,
              height: 100,
              child: Center(
                  child: Text(
                    clientSummaryModel.clientManger,
                    style: TextStyle(fontSize: 14),
                  ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clientSummaryModel.clientName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  clientSummaryModel.clientPhoneNumber,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  clientSummaryModel.clientResource,
                  style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
