import 'dart:math';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:property_service_web/models/property_item_model.dart';
import 'package:property_service_web/widgets/property_grid.dart';
import 'package:property_service_web/widgets/sub_layout.dart';

import '../../core/constants/app_colors.dart';
import '../../core/enums/button_type.dart';
import '../../core/enums/main_screen_type.dart';
import '../../core/utils/dialog_utils.dart';
import '../../core/utils/toast_manager.dart';
import '../../models/photo_item_model.dart';
import '../../models/property_summary.dart';
import '../../models/remark_model.dart';
import '../../widgets/crud_button.dart';
import '../../widgets/custom_address_field.dart';
import '../../widgets/custom_radio_group.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/grid/custom_grid.dart';
import '../../widgets/grid/custom_grid_model.dart';
import '../../widgets/image_slider_dialog.dart';
import '../../widgets/photo_list.dart';
import '../../widgets/remark_grid.dart';
import '../../widgets/side_search_grid.dart';
import '../../widgets/sub_title.dart';

class SalesPropertyListView extends StatefulWidget {
  const SalesPropertyListView({super.key});

  @override
  State<SalesPropertyListView> createState() => _SalesPropertyListViewState();
}

class _SalesPropertyListViewState extends State<SalesPropertyListView> {
  TextEditingController propertySearchWord = TextEditingController();

  late List<String> searchConditionList;
  late List<PropertySummary> propertySummaryList;
  late List<Widget> gridItemList;
  late List<PropertyItemModel> propertyItemList;

  bool _isExpanded = false; // 접기/펼치기 상태 변수
  bool _isLoading = false;

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

  final List<PhotoItemModel> photoModelList = [
    PhotoItemModel(photo: Uint8List(12)),
    PhotoItemModel(photo: Uint8List(31)),
    PhotoItemModel(photo: Uint8List(23)),
  ];

  void onSelectItemImageList(int id) async {
    showDialog(
      context: context,
      builder: (context) {
        return ImageSliderDialog();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    searchConditionList = [
      "매물 주소",
      "임대인",
      "임대인 전화번호"
    ];
    propertySummaryList = [
      PropertySummary(
          id: 1,
          representativeImage: null,
          buildingName: "건물1",
          buildingAddress: "부산광역시 강서구 녹산산단382로14번가길 10~29번지(송정동) 101호",
          buildingPostCode: '12345',
          propertyRoomNumber: "201호",
          propertySellType: "월세",
          propertyPrice: "300/30만 원"
      ),
      PropertySummary(
          id: 2,
          representativeImage: null,
          buildingName: "건물2",
          buildingAddress: "서울 특별시 강남구 삼성동 123-1",
          buildingPostCode: '12345',
          propertyRoomNumber: "1106호",
          propertySellType: "전세",
          propertyPrice: "3000만 원"
      ),
      PropertySummary(
          id: 3,
          representativeImage: null,
          buildingName: "건물3",
          buildingAddress: "서울 특별시 강동구 둔촌동 123-1",
          buildingPostCode: '12345',
          propertyRoomNumber: "502호",
          propertySellType: "매매",
          propertyPrice: "1억 원"
      ),

    ];
    propertyItemList = [
      PropertyItemModel(id: 1, transactionType: "월세", price: "300/30 만 원", address: "서울특별시 강남구 삼성동 123-1 103호", propertyOwner: "임대인1", propertyManager: "담당자1", propertyStatus: "상태1"),
      PropertyItemModel(id: 2, transactionType: "전세", price: "5억 원", address: "서울특별시 서초구 서초동 456-2 201호", propertyOwner: "임대인2", propertyManager: "담당자2", propertyStatus: "상태2"),
      PropertyItemModel(id: 3, transactionType: "매매", price: "12억 원", address: "서울특별시 용산구 한남동 789-3 301호", propertyOwner: "임대인3", propertyManager: "담당자3", propertyStatus: "상태3"),
      PropertyItemModel(id: 4, transactionType: "월세", price: "500/50 만 원", address: "서울특별시 마포구 합정동 555-4 101호", propertyOwner: "임대인4", propertyManager: "담당자4", propertyStatus: "상태4"),
      PropertyItemModel(id: 5, transactionType: "전세", price: "7억 원", address: "서울특별시 송파구 잠실동 999-5 202호", propertyOwner: "임대인5", propertyManager: "담당자5", propertyStatus: "상태5"),
      PropertyItemModel(id: 6, transactionType: "매매", price: "15억 원", address: "서울특별시 성동구 성수동 111-6 401호", propertyOwner: "임대인6", propertyManager: "담당자6", propertyStatus: "상태6"),
    ];
    super.initState();
  }

  void onUpdateBuildingInfo() async {

    String? buildingUsage;
    String? elevatorAvailable;
    String? violationStatus;
    String? mainPassword;

    bool? result = await DialogUtils.showCustomDialog(
        context: context,
        maxWidth: 1000,
        title: "건물 정보 수정",
        child: Column(
          children: [
            CustomTextField(label: "건물 이름", controller: TextEditingController(text: "제일 긴 주소 건물 이름")),
            CustomAddressField(label: "건물 주소", zipCode: "13494", address: "부산광역시 강서구 녹산단382로14번가길  10~29번지(송정동)"),
            Row(
              children: [
                Expanded(child: CustomTextField(label: "주차 대수", controller: TextEditingController())),
                Expanded(child: CustomTextField(label: "층 수", controller: TextEditingController())),
              ],
            ),
            Row(
              children: [
                Expanded(child: CustomTextField(label: "주 출입문 방향", controller: TextEditingController())),
                Expanded(child: CustomTextField(label: "준공 연도", controller: TextEditingController())),
              ],
            ),
            SizedBox(
              width: 800,
              child: Row(
                children: [
                  SizedBox(
                    width: 240,
                    child: CustomRadioGroup(
                      title: "건물 용도",
                      options: ["주거용", "비 주거용"],
                      groupValue: buildingUsage,
                      onChanged: (value) => setState(() => buildingUsage = value),
                    ),
                  ),
                  CustomRadioGroup(
                    title: "승강기 유무",
                    options: ["있음", "없음"],
                    groupValue: elevatorAvailable,
                    onChanged: (value) => setState(() => elevatorAvailable = value),
                    otherInput: "있음",
                    otherLabel: "승강기 대수",
                    otherInputTextController: TextEditingController(),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 800,
              child: Row(
                children: [
                  SizedBox(
                    width: 240,
                    child: CustomRadioGroup(
                      title: "위반 건축물 여부",
                      options: ["있음", "없음"],
                      groupValue: violationStatus,
                      onChanged: (value) => setState(() => violationStatus = value),
                    ),
                  ),
                  CustomRadioGroup(
                    title: "공동 현관문 비밀번호",
                    options: ["있음", "없음"],
                    groupValue: mainPassword,
                    onChanged: (value) => setState(() => mainPassword = value),
                    otherInput: "있음",
                    otherLabel: "공동 현관문 비밀번호",
                    otherInputTextController: TextEditingController(),
                    otherInputBoxWidth: 300,
                  ),
                ],
              ),
            ),
          ],
        ),
        onConfirm: () async {
          Navigator.pop(context, true);
          return null;
        }
    );

    setState(() {
      _isLoading = true; // 로딩 시작
    });
    await Future.delayed(Duration(seconds: 3)); // todo 고객 등록 api 연결
    setState(() {
      _isLoading = false; // 로딩 종료
    });

    ToastManager().showToast(context, "건물 정보를 수정 했습니다.");
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      mainScreenType: MainScreenType.SalesPropertyList,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 400,
            height: 800,
            child: SideSearchGrid(
              searchWord: propertySearchWord,
              gridItemList: propertySummaryList
                  .map((property) => _buildPropertyItem(property))
                  .toList(),
              searchConditionList: searchConditionList,
              searchConditionListWidth: 168,
              hintText: "",
              onSearchChanged: (_) {},
              onSearchPressed: () {},
            ),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 800,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubTitle(title: "건물 정보"),
                    _isExpanded
                        ? SizedBox(
                      height: 32,
                      child: CRUDButton(
                          buttonType: ButtonType.update,
                          onPressed: () {
                            onUpdateBuildingInfo();
                          }),
                    )
                        : SizedBox.shrink()
                  ],
                ),
              ),
              Container(
                width: 800,
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "제일 긴 주소 건물 이름",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 16),
                        AutoSizeText(
                          "(13494) 부산광역시 강서구 녹산산단382로14번가길 10~29번지(송정동)",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16, // 기본 글자 크기
                            fontWeight: FontWeight.w400,
                          ),
                          minFontSize: 12, // 최소 글자 크기
                          overflow: TextOverflow.ellipsis, // 넘칠 경우 ... 처리
                        )
                      ],
                    ),
                    if (_isExpanded)
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 150,
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "주차 대수",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "2 대",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 200,
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "충 수",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "6 층",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 180,
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "주 출입문 방향",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "남동향",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 240,
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "준공 연도",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "2024년",
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
                          Row(
                            children: [
                              Container(
                                width: 150,
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "건축 용도",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "주거용",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 200,
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "위반 건축물 여부",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "없음",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 180,
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "승강기 여부",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "2 대",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 240,
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "공동 현관문 비밀번호",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "12345*",
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
                          SizedBox(
                            width: 800,
                            height: 240,
                            child:  ReusableGrid(
                              title: "특이사항",
                              itemList: [],
                              // ? []
                              // : clientDetailModel!.clientRemarkList.map((remark)=> BuildClientRemarkItem(remark: remark, onDelete: fetchRemarkDelete)).toList(),
                              columns: [
                                CustomGridModel(header: "특이사항", flex: 3),
                                CustomGridModel(header: "작성자", flex: 1),
                                CustomGridModel(header: "작성일자", flex: 1),],
                              onPressAdd: () {},
                              canDelete: true,
                              contentGridHeight: 120,
                              isToggle: false,
                            ),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: 800,
                            height: 120,
                            child: PhotoList(photoList: photoModelList),
                          ),
                        ],
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
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
                                    _isExpanded ? "건물 상세 정보 닫기" : "건물 상세 정보 열기",
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
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 800,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubTitle(title: "임대인"),
                        // CRUDButton(buttonType: ButtonType.update, onPressed: (){})
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "임대인1 (사장님)  010 - 1234 - 1234",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 800,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubTitle(title: "매물 정보"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 400,
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "호 수",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "302 호",
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
                        Container(
                          width: 400,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                "매물 형태",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "원룸",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 400,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "월세",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "300/30 만원",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "단기",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "1000/50 만원",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 400,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "관리비",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "100,000 만원",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "수도, 전기, 인터넷, 난방, 조식, 룸 서비스",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 720,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    Text(
                                      "헤딩 층/전체 층",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "B1/4",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 24),
                              SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    Text(
                                      "방/욕실 개수",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "1/1",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 24),
                              SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    Text(
                                      "주실 기준 방향",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "남동향",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 720,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    Text(
                                      "전용/공급 면적",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "모르겠어요오...",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 24),
                              SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    Text(
                                      "사용 승인 일",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "2025.01.01",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 24),
                              SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    Text(
                                      "입주 가능 일",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "2025.01.01",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
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
                              SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    Text(
                                      "주차 가능 대수",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "1 대",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 24),
                              SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    Text(
                                      "난방 방식",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "개별",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 24),
                              SizedBox(
                                width: 280,
                                child: Row(
                                  children: [
                                    Text(
                                      "옵션",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "세탁기, 전자레인지, 냉장고, 에어컨, 침대",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 800,
                          height: 280,
                          padding: EdgeInsets.all(16),
                          child: ReusableGrid(
                            title: "특이사항",
                            itemList: [],
                            // ? []
                            // : clientDetailModel!.clientRemarkList.map((remark)=> BuildClientRemarkItem(remark: remark, onDelete: fetchRemarkDelete)).toList(),
                            columns: [
                              CustomGridModel(header: "특이사항", flex: 3),
                              CustomGridModel(header: "작성자", flex: 1),
                              CustomGridModel(header: "작성일자", flex: 1),],
                            onPressAdd: () {},
                            canDelete: true,
                            contentGridHeight: 120,
                            isToggle: false,
                          ),
                        ),
                        Container(
                          width: 800,
                          height: 216,
                          padding: EdgeInsets.all(16),
                          child: PhotoList(photoList: photoModelList),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   width: 1000,
              //   height: 480,
              //   child: PropertyGrid(
              //       propertyItemList: propertyItemList,
              //       onDelete: (_){},
              //   ),
              // )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyItem(PropertySummary propertySummary) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              onSelectItemImageList(1);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: propertySummary.representativeImage != null &&
                  propertySummary.representativeImage!.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(
                  propertySummary.representativeImage!,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              )
                  : Container(
                width: 120,
                height: 120,
                color: Colors.grey.shade300,
                child: Center(
                    child: Text(
                      "No Image",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    )),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  propertySummary.buildingName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "(${propertySummary.buildingPostCode}) ${propertySummary.buildingAddress} ${propertySummary.propertyRoomNumber}",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  "${propertySummary.propertySellType} ${propertySummary.propertyPrice}",
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
