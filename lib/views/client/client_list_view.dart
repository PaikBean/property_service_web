import 'package:flutter/material.dart';
import 'package:property_service_web/core/enums/button_type.dart';
import 'package:property_service_web/core/utils/dialog_utils.dart';
import 'package:property_service_web/core/utils/format_utils.dart';
import 'package:property_service_web/models/client_schedule_item_model.dart';
import 'package:property_service_web/models/client_showing_property_model.dart';
import 'package:property_service_web/models/client_summary_model.dart';
import 'package:property_service_web/models/common/schedule_add_request.dart';
import 'package:property_service_web/views/client/models/client_detail_model.dart';
import 'package:property_service_web/views/client/models/client_schedule_model.dart';
import 'package:property_service_web/views/client/models/showing_property_model.dart';
import 'package:property_service_web/widgets/grid/custom_grid_model.dart';
import 'package:property_service_web/widgets/side_search_future_grid.dart';
import 'package:property_service_web/widgets/sub_layout.dart';
import 'package:property_service_web/widgets/sub_title.dart';

import '../../core/enums/main_screen_type.dart';
import 'package:property_service_web/views/client/models/remark_model.dart';
import '../../core/utils/toast_manager.dart';
import '../../models/common/remark_add_request.dart';
import '../../widgets/grid/custom_grid.dart';
import '../../widgets/rotating_house_indicator.dart';
import 'models/client_summary_item.dart';

class ClientListView extends StatefulWidget {
  const ClientListView({super.key});

  @override
  State<ClientListView> createState() => _ClientListViewState();
}

class _ClientListViewState extends State<ClientListView> {
  bool _isLoading = false;

  List<String> searchConditionList = ["담당자", "고객", "고객 전화번호",];
  String searchConditionSelected = "담당자";
  TextEditingController clientSearchWord = TextEditingController();

  List<ClientSummaryItem> clientSummaryItemList = [];
  ClientDetailModel? clientDetailModel;

  // 고객 일정 추가
  Future<void> fetchOnScheduleAdd() async {
    ScheduleAddRequest? schedule = await DialogUtils.showAddScheduleDialog(context: context);
    if(schedule != null) {
      setState(() {
        _isLoading = true; // 로딩 상태 활성화
      });
      print("일정 추가 : ${schedule.scheduleDateTime.toIso8601String()}");
      await Future.delayed(Duration(seconds: 1)); // 예시를 위한 딜레이
      setState(() {
        _isLoading = false; // 로딩 상태 비활성화
      });
      ToastManager().showToast(context, "일정이 추가 되었습니다.");
      // 데이터 재조회
      onPressSideGridItem();
    }
  }

  // 고객 보여줄 매물 추가
  Future<void> fetchOnShowingPropertyAdd() async {
    ScheduleAddRequest? schedule = await DialogUtils.showAddShowingPropertyDialog(context: context);
    if(schedule != null) {
      setState(() {
        _isLoading = true; // 로딩 상태 활성화
      });
      await Future.delayed(Duration(seconds: 1)); // 예시를 위한 딜레이
      setState(() {
        _isLoading = false; // 로딩 상태 비활성화
      });
      ToastManager().showToast(context, "보여줄 매물이 추가 되었습니다.");
      // 데이터 재조회
      onPressSideGridItem();
    }
  }

  // 고객 특이사항 추가
  Future<void> fetchRemarkAdd() async {
    RemarkAddRequest? remark = await DialogUtils.showAddRemarkDialog(context: context);
    if(remark != null) {
      setState(() {
        _isLoading = true; // 로딩 상태 활성화
      });
      print("특이사항 추가 : ${remark.remark}");
      await Future.delayed(Duration(seconds: 1)); // 예시를 위한 딜레이
      setState(() {
        _isLoading = false; // 로딩 상태 비활성화
      });

      ToastManager().showToast(context, "특이사항이 추가 되었습니다.");
      // 데이터 재조회
      onPressSideGridItem();
    }
  }

  // 고객 일정 삭제
  Future<void> fetchOnScheduleDelete(int scheduleId) async {
    setState(() {
      _isLoading = true; // 로딩 상태 활성화
    });

    print("$scheduleId 삭제!");

    // 실제 삭제 작업 (API 호출 등)
    await Future.delayed(Duration(seconds: 1)); // 예시를 위한 딜레이

    setState(() {
      _isLoading = false; // 로딩 상태 비활성화
    });
    ToastManager().showToast(context, "해당 일정이 삭제 되었습니다.");
    // 데이터 재조회
    onPressSideGridItem();
  }

  // 고객 보여줄 매물 삭제
  Future<void> fetchOnShowingPropertyDelete(int showingPropertyId) async {
    setState(() {
      _isLoading = true; // 로딩 상태 활성화
    });

    await Future.delayed(Duration(seconds: 1));     // todo 스케쥴 삭제 api 호출

    setState(() {
      _isLoading = false; // 로딩 상태 활성화
    });
    ToastManager().showToast(context, "해당 보여줄 매물이 삭제 되었습니다.");
    onPressSideGridItem();    // 재조회
  }

  // 고객 특이사항 삭제
  Future<void> fetchRemarkDelete(int remarkId) async {
    setState(() {
      _isLoading = true; // 로딩 상태 활성화
    });
    
    await Future.delayed(Duration(seconds: 1));     // todo 스케쥴 삭제 api 호출

    setState(() {
      _isLoading = true; // 로딩 상태 활성화
    });
    ToastManager().showToast(context, "해당 특이사항이 삭제 되었습니다.");
    onPressSideGridItem();    // 재조회
  }

  @override
  void initState() {
    super.initState();
  }

  // 고객 목록 조회
  void onSearchSideGrid() async {
    await fetchClientSummaryItemList();
  }

  // 고객 요약 목록 호출
  Future<List<Widget>> fetchClientSummaryItemList() async {
    List<ClientSummaryItem> clients = mockClientSummaryItems;     // todo 고객 요약 목록 조회 api 적용

    await Future.delayed(Duration(seconds: 1));
    return clients.map((cli) => _buildClientItem(cli)).toList();
  }

  // 고객 정보 조회
  void onPressSideGridItem() async {
    setState(() {
      _isLoading = true; // 로딩 시작
    });

    await fetchClientDetail(); // 데이터 로드 완료 대기

    setState(() {
      _isLoading = false; // 로딩 종료
    });
  }

  // 고객 상세 정보 호출
  Future<void> fetchClientDetail() async {
    await Future.delayed(Duration(seconds: 1));
    clientDetailModel = ClientDetailModel.fromJson(mockClientDetail);
  }

  Future<void> fetchUpdateClientDetail() async {
    bool clientUpdateNow = await DialogUtils.showConfirmDialog(context: context, title: "수정 진입", content: "고객 정보를 수정하시겠습니까?");
    if(clientUpdateNow){

      setState(() {
        _isLoading = true; // 로딩 시작
      });

      await Future.delayed(Duration(seconds: 1)); // todo 수정 가능 여부 확인 및 락 api 호출


      if(DateTime.now().second%2 == 0){
        setState(() {
          _isLoading = false; // 로딩 종료
        });
        DialogUtils.showAlertDialog(context: context, title: "수정 진입 실패", content: "다른 사용자가 수정 중 입니다.");
      } else{
        ClientDetailModel client = clientDetailModel!;
        await Future.delayed(Duration(seconds: 1)); // 고객 정보 받아오기 api
        setState(() {
          _isLoading = false; // 로딩 종료
        });

        ClientDetailModel? updateClient = await DialogUtils.showUpdateClientDialog(context: context, client: client);

        if(updateClient != null){
          setState(() {
            _isLoading = true; // 로딩 상태 활성화
          });

          await Future.delayed(Duration(seconds: 1)); // 고객 정보 업데이트 api

          setState(() {
            _isLoading = false; // 로딩 상태 비활성화
          });

          ToastManager().showToast(context, "고객정보가 수정 되었습니다.");
          // 데이터 재조회
          onPressSideGridItem();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SubLayout(
          mainScreenType: MainScreenType.ClientList,
          buttonTypeList: clientDetailModel == null ? [] : [ButtonType.update],
          onUpdatePressed: () async {
            await fetchUpdateClientDetail();
          },
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
                  onSearchChanged: (value) => searchConditionSelected = value,
                  onSearchPressed: () => onSearchSideGrid(),
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
                    height: 240,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ReusableGrid(
                      title: "일정",
                      itemList: clientDetailModel == null
                          ? []
                          : clientDetailModel!.clientScheduleList.map((schedule)=> BuildClientScheduleItem(clientSchedule: schedule, onDelete: fetchOnScheduleDelete)).toList(),
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
                    height: 240,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ReusableGrid(
                      title: "보여줄 매물",
                      itemList: clientDetailModel == null
                          ? []
                          : clientDetailModel!.showingPropertyList.map((property)=> BuildClientShowingPropertyItem(property: property, onDelete: fetchOnShowingPropertyDelete)).toList(),
                      columns: [
                        CustomGridModel(header: "거래 유형", flex: 1),
                        CustomGridModel(header: "매물 가격", flex: 1),
                        CustomGridModel(header: "매물 형태", flex: 1),
                        CustomGridModel(header: "매물 주소", flex: 2),
                      ],
                      onPressAdd: clientDetailModel == null ? null : () => fetchOnShowingPropertyAdd(),
                      canDelete: true,
                      contentGridHeight: 150,
                      isToggle: false,
                    ),
                  ),
                  Container(
                    width: 960,
                    height: 280,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ReusableGrid(
                      title: "특이사항",
                      itemList: clientDetailModel == null
                          ? []
                          : clientDetailModel!.clientRemarkList.map((remark)=> BuildClientRemarkItem(remark: remark, onDelete: fetchRemarkDelete)).toList(),
                      columns: [
                        CustomGridModel(header: "특이사항", flex: 3),
                        CustomGridModel(header: "작성자", flex: 1),
                        CustomGridModel(header: "작성일자", flex: 1),],
                      onPressAdd: clientDetailModel == null ? null : () => fetchRemarkAdd(),
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

class BuildClientRemarkItem extends StatefulWidget {
  final RemarkModel remark;
  final  Future<void> Function(int id) onDelete;
  const BuildClientRemarkItem({super.key, required this.remark, required this.onDelete});

  @override
  State<BuildClientRemarkItem> createState() => _BuildClientRemarkItemState();
}

class _BuildClientRemarkItemState extends State<BuildClientRemarkItem> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                widget.remark.remark,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                widget.remark.createByUserName,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                FormatUtils.formatToYYYYmmDDHHMM(widget.remark.createdAt),
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
              onPressed: () => widget.onDelete(widget.remark.remarkId),
            ),
          ),
        ],
      ),
    );
  }
}


class BuildClientScheduleItem extends StatefulWidget {
  final ClientScheduleModel clientSchedule;
  final Future<void> Function(int id) onDelete;
  const BuildClientScheduleItem({super.key, required this.clientSchedule, required this.onDelete});

  @override
  State<BuildClientScheduleItem> createState() => _BuildClientScheduleItemState();
}

class _BuildClientScheduleItemState extends State<BuildClientScheduleItem> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                widget.clientSchedule.picManagerName,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                widget.clientSchedule.clientScheduleDateTime,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                widget.clientSchedule.clientScheduleType,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                widget.clientSchedule.clientScheduleRemark,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isHovered ? 1.0 : 0.0,
            duration: Duration(milliseconds: 1),
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.grey),
              iconSize: 14, // 삭제 버튼 크기 조정
              onPressed: () => widget.onDelete(widget.clientSchedule.clientScheduleId),
            ),
          ),
        ],
      ),
    );
  }
}


class BuildClientShowingPropertyItem extends StatefulWidget {
  final ShowingPropertyModel property;
  final Future<void> Function(int id) onDelete;
  const BuildClientShowingPropertyItem({super.key, required this.property, required this.onDelete});

  @override
  State<BuildClientShowingPropertyItem> createState() => _BuildClientShowingPropertyItemState();
}

class _BuildClientShowingPropertyItemState extends State<BuildClientShowingPropertyItem> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                widget.property.propertySellType,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                widget.property.propertyPrice,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                widget.property.propertyType,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                widget.property.propertyAddress,
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
              onPressed: () => widget.onDelete(widget.property.showingPropertyId),
            ),
          ),
        ],
      ),
    );
  }
}

