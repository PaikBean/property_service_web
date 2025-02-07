import 'package:flutter/material.dart';
import 'package:property_service_web/core/enums/button_type.dart';
import 'package:property_service_web/core/utils/format_utils.dart';
import 'package:property_service_web/models/client_schedule_item_model.dart';
import 'package:property_service_web/models/client_showing_property_model.dart';
import 'package:property_service_web/models/client_summary_model.dart';
import 'package:property_service_web/views/client/models/client_detail_model.dart';
import 'package:property_service_web/views/client/models/client_schedule_model.dart';
import 'package:property_service_web/views/client/models/showing_property_model.dart';
import 'package:property_service_web/widgets/grid/custom_grid_model.dart';
import 'package:property_service_web/widgets/side_search_future_grid.dart';
import 'package:property_service_web/widgets/sub_layout.dart';
import 'package:property_service_web/widgets/sub_title.dart';

import '../../core/enums/main_screen_type.dart';
import 'package:property_service_web/views/client/models/remark_model.dart';
import '../../widgets/grid/custom_grid.dart';
import '../../widgets/remark_grid.dart';
import '../../widgets/rotating_house_indicator.dart';
import 'models/client_summary_item.dart';

class ClientListView extends StatefulWidget {
  const ClientListView({super.key});

  @override
  State<ClientListView> createState() => _ClientListViewState();
}

class _ClientListViewState extends State<ClientListView> {
  bool _isLoading = false;
  TextEditingController clientSearchWord = TextEditingController();

  List<ClientSummaryItem> clientSummaryItemList = [];
  ClientDetailModel? clientDetailModel;


  late List<String> searchConditionList;
  late List<ClientSummaryModel> clientSummaryModelList;
  late List<Widget> gridItemList;

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


  // 고객 요약 목록 호출
  Future<List<Widget>> fetchClientSummaryItemList() async {
    List<ClientSummaryItem> clients = mockClientSummaryItems; // todo 고객 요약 목록 조회 api 적용
    await Future.delayed(Duration(seconds: 1));
    return clients.map((cli) => _buildClientItem(cli)).toList();
  }

  // 고객 상세 정보 호출
  Future<void> fetchClientDetail() async {
    await Future.delayed(Duration(seconds: 1));
    clientDetailModel = ClientDetailModel.fromJson(mockClientDetail);
  }

  // 고객 일정 삭제
  Future<void> fetchOnScheduleDelete(int scheduleId) async {
    print("$scheduleId 삭제!");
    await Future.delayed(Duration(seconds: 1));     // todo 스케쥴 삭제 api 호출

    onPressSideGridItem();    // 재조회
  }

  Future<void> fetchOnScheduleAdd() async {
    print("스케쥴 등록 팝업");
  }

  @override
  void initState() {
    searchConditionList = [
      "담당자",
      "고객",
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

  void onSearchSideGrid() async {
    setState(() {
      clientSummaryItemList = mockClientSummaryItems;
    });
  }

  void onPressSideGridItem() async {
    setState(() {
      _isLoading = true; // 로딩 시작
    });

    await fetchClientDetail(); // 데이터 로드 완료 대기

    setState(() {
      _isLoading = false; // 로딩 종료
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SubLayout(
          mainScreenType: MainScreenType.ClientList,
          buttonTypeList: clientDetailModel == null ? [] : [ButtonType.update],
          onUpdatePressed: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 400,
                height: 840,
                child: SideSearchFutureGrid(
                  searchWord: clientSearchWord,
                  searchConditionList: searchConditionList,
                  searchConditionListWidth: 152,
                  hintText: "",
                  onSearchChanged: (value) {onSearchSideGrid();},
                  onSearchPressed: () {onSearchSideGrid();},
                  fetchGridItems: fetchClientSummaryItemList, // Future 함수 전달
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubTitle(title: "고객 정보"),
                  SizedBox(height: 8),
                  Container(
                    width: 800,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              Text(
                                "성함",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                clientDetailModel != null && clientDetailModel?.clientName != null
                                    ? "${clientDetailModel!.clientName}${clientDetailModel?.genderType != null ? " (${clientDetailModel!.genderType.label.substring(0,1)})" : ""}"
                                    : "",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Text(
                                "전화번호",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                clientDetailModel?.clientPhoneNumber ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              Text(
                                "담당자",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                clientDetailModel?.picManagerName ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 40),
                        SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              Text(
                                "상태",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                clientDetailModel?.clientStatusType.label ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 1000,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
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
                                clientDetailModel?.clientSourceType.label ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              Text(
                                "고객 유형",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                clientDetailModel?.clientType.label ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              Text(
                                "거래유형",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                clientDetailModel?.clientExpectedTradeTypeList.first.label ?? "", // 쉼표로 연결
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 40),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Text(
                                "입주 예정일",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                clientDetailModel == null ? "" : FormatUtils.formatToYYYYMMDD(clientDetailModel!.clientExpectedMoveInDate),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 960,
                    height: 248,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ReusableGrid(
                      title: "일정",
                      itemList: clientDetailModel == null
                          ? []
                          : clientDetailModel!.clientScheduleList.map((schedule)=> _buildClientScheduleItem(schedule)).toList(),
                      columns: [
                        CustomGridModel(header: "담당자", flex: 1),
                        CustomGridModel(header: "일시", flex: 1),
                        CustomGridModel(header: "일정 유형", flex: 1),
                        CustomGridModel(header: "특이 사항", flex: 2),
                      ],
                      onPressAdd: clientDetailModel == null ? null : () => fetchOnScheduleAdd(),
                      canDelete: true,
                      contentGridHeight: 150,
                      isToggle: false,
                    ),
                  ),
                  Container(
                    width: 960,
                    height: 248,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ReusableGrid(
                      title: "보여줄 매물",
                      itemList: clientDetailModel == null
                          ? []
                          : clientDetailModel!.showingPropertyList.map((property)=> _buildClientShowingPropertyItem(property)).toList(),
                      columns: [
                        CustomGridModel(header: "거래 유형", flex: 1),
                        CustomGridModel(header: "매물 가격", flex: 1),
                        CustomGridModel(header: "매물 형태", flex: 1),
                        CustomGridModel(header: "매물 주소", flex: 2),
                      ],
                      onPressAdd: clientDetailModel == null ? null : () => fetchOnScheduleAdd(),
                      canDelete: true,
                      contentGridHeight: 150,
                      isToggle: false,
                    ),
                  ),
                  Container(
                    width: 960,
                    height: 288,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ReusableGrid(
                      title: "특이사항",
                      itemList: clientDetailModel == null
                          ? []
                          : clientDetailModel!.clientRemarkList.map((remark)=> _buildClientRemarkItem(remark)).toList(),
                      columns: [
                        CustomGridModel(header: "특이사항", flex: 3),
                        CustomGridModel(header: "작성자", flex: 1),
                        CustomGridModel(header: "작성일자", flex: 1),],
                      onPressAdd: clientDetailModel == null ? null : () => fetchOnScheduleAdd(),
                      canDelete: true,
                      contentGridHeight: 150,
                      isToggle: true,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black.withAlpha(1), // 반투명 배경
              ),
              child: Center(
                child: RotatingHouseIndicator(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildClientRemarkItem(RemarkModel remark){

    bool isHovered = false;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                remark.remark,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                remark.createByUserName,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                FormatUtils.formatToYYYYmmDDHHMM(remark.createdAt),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isHovered ? 1.0 : 0.0,
            duration: Duration(milliseconds: 100),
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.grey),
              iconSize: 16, // 삭제 버튼 크기 조정
              onPressed: () => fetchOnScheduleDelete(remark.remarkId),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientShowingPropertyItem(ShowingPropertyModel property){

    bool isHovered = false;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                property.propertySellType,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                property.propertyPrice,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                property.propertyType,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                property.propertyAddress,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isHovered ? 1.0 : 0.0,
            duration: Duration(milliseconds: 100),
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.grey),
              iconSize: 16, // 삭제 버튼 크기 조정
              onPressed: () => fetchOnScheduleDelete(property.showingPropertyId),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientScheduleItem(ClientScheduleModel clientSchedule){
    
    bool isHovered = false;
    
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                clientSchedule.picManagerName,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                clientSchedule.clientScheduleDateTime,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                clientSchedule.clientScheduleType,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                clientSchedule.clientScheduleRemark,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isHovered ? 1.0 : 0.0,
            duration: Duration(milliseconds: 100),
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.grey),
              iconSize: 16, // 삭제 버튼 크기 조정
              onPressed: () => fetchOnScheduleDelete(clientSchedule.clientScheduleId),
            ),
          ),
        ],
      ),
    );
  } 

  Widget _buildClientItem(ClientSummaryItem clientSummaryItem) {
    return GestureDetector(
      onTap: onPressSideGridItem,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      clientSummaryItem.clientName,
                      style: TextStyle(
                          fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      clientSummaryItem.clientStatus,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clientSummaryItem.clientPhoneNumber,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        clientSummaryItem.picManagerName,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[800]),
                      ),
                      Text(
                        "   :   ",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        clientSummaryItem.clientSourceLabel,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[800]),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "입주 예정일 : ${clientSummaryItem.clientExpectedMoveInDate}",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
