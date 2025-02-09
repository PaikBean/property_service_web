import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:property_service_web/core/enums/button_type.dart';
import 'package:property_service_web/core/enums/main_screen_type.dart';
import 'package:property_service_web/core/utils/dialog_utils.dart';
import 'package:property_service_web/models/building_summary.dart';
import 'package:property_service_web/models/maintenance_form.dart';
import 'package:property_service_web/models/photo_item_model.dart';
import 'package:property_service_web/models/remark_model.dart';
import 'package:property_service_web/widgets/crud_button.dart';
import 'package:property_service_web/widgets/custom_address_field.dart';
import 'package:property_service_web/widgets/custom_radio_group.dart';
import 'package:property_service_web/widgets/custom_text_field.dart';
import 'package:property_service_web/widgets/maintenance_cost_form.dart';
import 'package:property_service_web/widgets/photo_list.dart';
import 'package:property_service_web/widgets/property_sell_type.dart';
import 'package:property_service_web/widgets/remark_grid.dart';
import 'package:property_service_web/widgets/side_search_grid.dart';
import 'package:property_service_web/widgets/sub_layout.dart';
import 'package:property_service_web/widgets/sub_title.dart';

import '../../core/constants/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../core/enums/datepicker_type.dart';
import '../../core/utils/toast_manager.dart';
import '../../models/image_file_list_model.dart';
import '../../widgets/custom_checkbox_group2.dart';
import '../../widgets/custom_datepicker.dart';
import '../../widgets/grid/custom_grid.dart';
import '../../widgets/grid/custom_grid_model.dart';
import '../../widgets/image_slider_dialog.dart';
import '../../widgets/photo_upload.dart';
import '../../widgets/rotating_house_indicator.dart';
import '../client/client_list_view.dart';

class SalesPropertyRegisterView extends StatefulWidget {
  const SalesPropertyRegisterView({super.key});

  @override
  State<SalesPropertyRegisterView> createState() =>
      _SalesPropertyRegisterViewState();
}

class _SalesPropertyRegisterViewState extends State<SalesPropertyRegisterView> {
  bool _isLoading = false;

  TextEditingController buildingSearchWord = TextEditingController();

  TextEditingController propertyOwnerName = TextEditingController();
  TextEditingController propertyOwnerPhoneNumber = TextEditingController();

  final TextEditingController monthlyDepositAmountController = TextEditingController();
  final TextEditingController monthlyAmountController = TextEditingController();
  final TextEditingController jeonseAmountController = TextEditingController();
  final TextEditingController saleAmountController = TextEditingController();
  final TextEditingController shortTermDepositAmountController = TextEditingController();
  final TextEditingController shortTermMonthlyAmountController = TextEditingController();

  String? propertyOwnerRelation;
  String? propertyType;
  String? propertyOptionType;
  String? propertyHeatingType;
  String? propertyParkingCount;

  ImageFileListModel buildingImageList = ImageFileListModel(imageFileModelList: []);

  MaintenanceFormModel maintenanceFormModel = MaintenanceFormModel(maintenanceFee: 0, isWaterSelected: false, isElectricitySelected: false, isInternetSelected: false, isHeatingSelected: false, others: "");

  late List<String> searchConditionList;
  late List<Widget> gridItemList;
  late String selectedSearchCondition;
  late List<BuildingSummary> buildingSummaryList;

  bool _isExpanded = false; // 접기/펼치기 상태 변수

  void onSelectItemImageList(int id) async {
    showDialog(
      context: context,
      builder: (context) {
        return ImageSliderDialog();
      },
    );
  }

  void onSubmit() async {
    setState(() {
      _isLoading = true; // 로딩 시작
    });
    await Future.delayed(Duration(seconds: 3)); // todo 고객 등록 api 연결
    setState(() {
      _isLoading = false; // 로딩 종료
    });

    ToastManager().showToast(context, "매물을 등록했습니다.");
    clearAllData();
  }

  // 입력 데이터 초기화
  void clearAllData() {

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
  void initState() {
    // TODO: implement initState
    searchConditionList = [
      "건물 주소",
    ];
    gridItemList = [];
    buildingSummaryList = [
      BuildingSummary(
          id: 1,
          representativeImage: null,
          buildingName: "건물1",
          buildingAddress: "서울 특별시 강남구 역삼동 123-1",
          buildingPostCode: '12345'),
      BuildingSummary(
          id: 2,
          representativeImage: null,
          buildingName: "건물2",
          buildingAddress: "서울 특별시 강남구 삼성동 123-1",
          buildingPostCode: '23456'),
      BuildingSummary(
          id: 3,
          representativeImage: null,
          buildingName: "건물3",
          buildingAddress: "서울 특별시 서초구 개포동 123-1",
          buildingPostCode: '34567'),
      BuildingSummary(
          id: 4,
          representativeImage: null,
          buildingName: "건물4",
          buildingAddress: "서울 특별시 강동구 둔촌동 123-1",
          buildingPostCode: '45645'),
      BuildingSummary(
          id: 1,
          representativeImage: null,
          buildingName: "건물1",
          buildingAddress: "서울 특별시 강남구 역삼동 123-1",
          buildingPostCode: '12345'),
      BuildingSummary(
          id: 2,
          representativeImage: null,
          buildingName: "건물2",
          buildingAddress: "서울 특별시 강남구 삼성동 123-1",
          buildingPostCode: '23456'),
      BuildingSummary(
          id: 3,
          representativeImage: null,
          buildingName: "건물3",
          buildingAddress: "서울 특별시 서초구 개포동 123-1",
          buildingPostCode: '34567'),
      BuildingSummary(
          id: 4,
          representativeImage: null,
          buildingName: "건물4",
          buildingAddress: "서울 특별시 강동구 둔촌동 123-1",
          buildingPostCode: '45645'),      BuildingSummary(
          id: 1,
          representativeImage: null,
          buildingName: "건물1",
          buildingAddress: "서울 특별시 강남구 역삼동 123-1",
          buildingPostCode: '12345'),
      BuildingSummary(
          id: 2,
          representativeImage: null,
          buildingName: "건물2",
          buildingAddress: "서울 특별시 강남구 삼성동 123-1",
          buildingPostCode: '23456'),
      BuildingSummary(
          id: 3,
          representativeImage: null,
          buildingName: "건물3",
          buildingAddress: "서울 특별시 서초구 개포동 123-1",
          buildingPostCode: '34567'),
      BuildingSummary(
          id: 4,
          representativeImage: null,
          buildingName: "건물4",
          buildingAddress: "서울 특별시 강동구 둔촌동 123-1",
          buildingPostCode: '45645'),      BuildingSummary(
          id: 1,
          representativeImage: null,
          buildingName: "건물1",
          buildingAddress: "서울 특별시 강남구 역삼동 123-1",
          buildingPostCode: '12345'),
      BuildingSummary(
          id: 2,
          representativeImage: null,
          buildingName: "건물2",
          buildingAddress: "서울 특별시 강남구 삼성동 123-1",
          buildingPostCode: '23456'),
      BuildingSummary(
          id: 3,
          representativeImage: null,
          buildingName: "건물3",
          buildingAddress: "서울 특별시 서초구 개포동 123-1",
          buildingPostCode: '34567'),
      BuildingSummary(
          id: 4,
          representativeImage: null,
          buildingName: "건물4",
          buildingAddress: "서울 특별시 강동구 둔촌동 123-1",
          buildingPostCode: '45645'),      BuildingSummary(
          id: 1,
          representativeImage: null,
          buildingName: "건물1",
          buildingAddress: "서울 특별시 강남구 역삼동 123-1",
          buildingPostCode: '12345'),
      BuildingSummary(
          id: 2,
          representativeImage: null,
          buildingName: "건물2",
          buildingAddress: "서울 특별시 강남구 삼성동 123-1",
          buildingPostCode: '23456'),
      BuildingSummary(
          id: 3,
          representativeImage: null,
          buildingName: "건물3",
          buildingAddress: "서울 특별시 서초구 개포동 123-1",
          buildingPostCode: '34567'),
      BuildingSummary(
          id: 4,
          representativeImage: null,
          buildingName: "건물4",
          buildingAddress: "서울 특별시 강동구 둔촌동 123-1",
          buildingPostCode: '45645'),      BuildingSummary(
          id: 1,
          representativeImage: null,
          buildingName: "건물1",
          buildingAddress: "서울 특별시 강남구 역삼동 123-1",
          buildingPostCode: '12345'),
      BuildingSummary(
          id: 2,
          representativeImage: null,
          buildingName: "건물2",
          buildingAddress: "서울 특별시 강남구 삼성동 123-1",
          buildingPostCode: '23456'),
      BuildingSummary(
          id: 3,
          representativeImage: null,
          buildingName: "건물3",
          buildingAddress: "서울 특별시 서초구 개포동 123-1",
          buildingPostCode: '34567'),
      BuildingSummary(
          id: 4,
          representativeImage: null,
          buildingName: "건물4",
          buildingAddress: "서울 특별시 강동구 둔촌동 123-1",
          buildingPostCode: '45645'),      BuildingSummary(
          id: 1,
          representativeImage: null,
          buildingName: "건물1",
          buildingAddress: "서울 특별시 강남구 역삼동 123-1",
          buildingPostCode: '12345'),
      BuildingSummary(
          id: 2,
          representativeImage: null,
          buildingName: "건물2",
          buildingAddress: "서울 특별시 강남구 삼성동 123-1",
          buildingPostCode: '23456'),
      BuildingSummary(
          id: 3,
          representativeImage: null,
          buildingName: "건물3",
          buildingAddress: "서울 특별시 서초구 개포동 123-1",
          buildingPostCode: '34567'),
      BuildingSummary(
          id: 4,
          representativeImage: null,
          buildingName: "건물4",
          buildingAddress: "서울 특별시 강동구 둔촌동 123-1",
          buildingPostCode: '45645'),      BuildingSummary(
          id: 1,
          representativeImage: null,
          buildingName: "건물1",
          buildingAddress: "서울 특별시 강남구 역삼동 123-1",
          buildingPostCode: '12345'),
      BuildingSummary(
          id: 2,
          representativeImage: null,
          buildingName: "건물2",
          buildingAddress: "서울 특별시 강남구 삼성동 123-1",
          buildingPostCode: '23456'),
      BuildingSummary(
          id: 3,
          representativeImage: null,
          buildingName: "건물3",
          buildingAddress: "서울 특별시 서초구 개포동 123-1",
          buildingPostCode: '34567'),
      BuildingSummary(
          id: 4,
          representativeImage: null,
          buildingName: "건물4",
          buildingAddress: "서울 특별시 강동구 둔촌동 123-1",
          buildingPostCode: '45645'),      BuildingSummary(
          id: 1,
          representativeImage: null,
          buildingName: "건물1",
          buildingAddress: "서울 특별시 강남구 역삼동 123-1",
          buildingPostCode: '12345'),
      BuildingSummary(
          id: 2,
          representativeImage: null,
          buildingName: "건물2",
          buildingAddress: "서울 특별시 강남구 삼성동 123-1",
          buildingPostCode: '23456'),
      BuildingSummary(
          id: 3,
          representativeImage: null,
          buildingName: "건물3",
          buildingAddress: "서울 특별시 서초구 개포동 123-1",
          buildingPostCode: '34567'),
      BuildingSummary(
          id: 4,
          representativeImage: null,
          buildingName: "건물4",
          buildingAddress: "서울 특별시 강동구 둔촌동 123-1",
          buildingPostCode: '45645'),
    ];
    selectedSearchCondition = searchConditionList[0];
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SubLayout(
          mainScreenType: MainScreenType.SalesPropertyRegister,
          buttonTypeList: [ButtonType.submit],
          onSubmitPressed: onSubmit,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 400,
                height: 1520,
                child: SideSearchGrid(
                  searchWord: buildingSearchWord,
                  gridItemList: buildingSummaryList
                      .map((building) => _buildBuildingItem(building))
                      .toList(),
                  searchConditionList: searchConditionList,
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
                  SubTitle(title: "임대인 정보"),
                  SizedBox(
                    width: 600,
                    child: Row(
                      children: [
                        Flexible(child: CustomTextField(label: "성명", controller: propertyOwnerName)),
                        Flexible(
                          flex: 2,
                          child: CustomTextField(
                              label: "전화번호", controller: propertyOwnerPhoneNumber),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 800,
                    child: CustomRadioGroup(
                        title: "관계",
                        options: ["사장님", "사모님", "기타"],
                        groupValue: propertyOwnerRelation,
                        onChanged: (value) =>
                            setState(() => propertyOwnerRelation = value),
                      otherInput: "기타",
                      otherLabel: "관계",
                      otherInputTextController: TextEditingController(),
                      otherInputBoxWidth: 200,
                    ),
                  ),
                  SubTitle(title: "매물 정보"),
                  SizedBox(
                    width: 800,
                    child: Row(
                      children: [
                        Flexible(child: CustomTextField(label: "상세 주소", controller: TextEditingController())),
                        SizedBox(
                          width: 600,
                          child: CustomRadioGroup(
                            title: "매물 형태",
                            options: ["원룸", "투룸", "기타"],
                            groupValue: propertyType,
                            onChanged: (value) =>
                                setState(() => propertyType = value),
                            otherInput: "기타",
                            otherLabel: "매물 형태",
                            otherInputTextController: TextEditingController(),
                            otherInputBoxWidth: 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 600, // 전체 Row의 최대 너비 제한
                    child: Row(
                      children: [
                        // 첫 번째 TextField
                        Flexible(
                          flex: 1, // 비율 설정
                          child: CustomTextField(
                            label: "해당 층/전체 층",
                            controller: TextEditingController(),
                          ),
                        ),
                        const SizedBox(width: 16), // 간격 추가
                        // 두 번째 TextField
                        Flexible(
                          flex: 1,
                          child: CustomTextField(
                            label: "방 욕실 갯수",
                            controller: TextEditingController(),
                          ),
                        ),
                        const SizedBox(width: 16), // 간격 추가
                        // 세 번째 TextField와 Tooltip
                        Flexible(
                          flex: 1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label: "기준 방향",
                                  controller: TextEditingController(),
                                ),
                              ),
                              Tooltip(
                                message: "현관문 기준",
                                child: Icon(
                                  Icons.info_outline,
                                  size: 20,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 600,
                    child: Row(
                      children: [
                        Flexible(flex: 1, child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: CustomTextField(label: "전용 면적", controller: TextEditingController())),
                            Tooltip(
                              message: "㎡ 기준",
                              child: Icon(
                                Icons.info_outline,
                                size: 20,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        )),
                        Flexible(flex: 1, child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: CustomTextField(label: "공급 면적", controller: TextEditingController())),
                            Tooltip(
                              message: "㎡ 기준",
                              child: Icon(
                                Icons.info_outline,
                                size: 20,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 600,
                    child: Row(
                      children: [
                        Flexible(flex: 1, child: CustomDatePicker(datePickerType: DatePickerType.date, label: "사용 승인일", selectedDateTime: DateTime.now())),
                        Flexible(child: CustomDatePicker(datePickerType: DatePickerType.date, label: "입주 가능일", selectedDateTime: DateTime.now())),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 800,
                    height: 200,
                      child: PropertySellType(
                          monthlyDepositAmountController: monthlyDepositAmountController,
                          monthlyAmountController: monthlyAmountController,
                          jeonseAmountController: jeonseAmountController,
                          saleAmountController: saleAmountController,
                          shortTermDepositAmountController: shortTermDepositAmountController,
                          shortTermMonthlyAmountController: shortTermMonthlyAmountController,
                      ),
                  ),
                  SizedBox(
                    width: 800,
                    height: 136,
                    child: MaintenanceCostForm(maintenanceFormModel: maintenanceFormModel),
                  ),
                  SizedBox(
                    width: 1000,
                    child: Row(
                      children: [
                        SizedBox(
                          width:400,
                          child: CustomRadioGroup(
                            title: "주차 가능 여부",
                            options: ["가능", "불가능",],
                            groupValue: propertyParkingCount,
                            onChanged: (value) =>
                                setState(() => propertyParkingCount = value),
                          ),
                        ),
                        SizedBox(
                          width:600,
                          child: CustomRadioGroup(
                            title: "난방 방식",
                            options: ["개별", "중앙", "심야"],
                            groupValue: propertyHeatingType,
                            onChanged: (value) =>
                                setState(() => propertyHeatingType = value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width:1000,
                    child:  CustomCheckboxGroup2(
                      title: "옵션",
                      options: ["풀옵션", "에어컨", "세탁기", "냉장고", "가스레인지"],
                      initialSelection: selectedOptions,
                      onChanged: (selections) {
                        setState(() {
                          selectedOptions = selections;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 800,
                    child: PhotoUpload(
                      label: "매물 사진 등록",
                      imageFileListModel: buildingImageList,
                      maxUploadCount: 5,
                      toolTipMessage: "매물 사진은 최대 5개까지 등록 가능합니다.",
                    ),
                  ),
                ],
              ),
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

  List<bool> selectedOptions = [false, false, false, false, false, false];

  Widget _buildBuildingItem(BuildingSummary buildingSummary) {
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
            onTap: () async {
              onSelectItemImageList(1);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: buildingSummary.representativeImage != null &&
                      buildingSummary.representativeImage!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        buildingSummary.representativeImage!,
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
                  buildingSummary.buildingName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "(${buildingSummary.buildingPostCode}) ${buildingSummary.buildingAddress}",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
