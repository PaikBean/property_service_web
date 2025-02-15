import 'package:property_service_web/core/enums/gender_type.dart';
import 'package:property_service_web/core/enums/transaction_type.dart';
import 'package:property_service_web/views/client/enums/client_source_type.dart';
import 'package:property_service_web/views/client/enums/client_status_type.dart';
import 'package:property_service_web/views/client/models/client_schedule_model.dart';
import 'package:property_service_web/views/client/models/remark_model.dart';
import 'package:property_service_web/views/client/models/showing_property_model.dart';
import '../enums/client_type_code.dart';

class ClientDetailModel {
  final int clientId;
  final String clientName;
  final String clientPhoneNumber;
  final String picManagerName;
  final ClientStatusType clientStatusType; // 고객 상태
  final GenderType genderType;
  final ClientType clientType;
  final ClientSource clientSourceType;
  final DateTime clientExpectedMoveInDate;
  final List<TransactionType> clientExpectedTradeTypeList;

  final List<ClientScheduleModel> clientScheduleList;
  final List<ShowingPropertyModel> showingPropertyList;
  final List<RemarkModel> clientRemarkList;

  ClientDetailModel({
    required this.clientId,
    required this.clientName,
    required this.clientPhoneNumber,
    required this.picManagerName,
    required this.clientStatusType,
    required this.genderType,
    required this.clientType,
    required this.clientSourceType,
    required this.clientExpectedMoveInDate,
    required this.clientExpectedTradeTypeList,
    required this.clientScheduleList,
    required this.showingPropertyList,
    required this.clientRemarkList,
  });

  // JSON -> Model 변환
  factory ClientDetailModel.fromJson(Map<String, dynamic> json) {
    return ClientDetailModel(
      clientId: json['clientId'] as int,

      clientName: json['clientName'] as String,
      clientPhoneNumber: json['clientPhoneNumber'] as String,
      picManagerName: json['picManagerName'] as String,

      clientStatusType: ClientStatusType.fromCode(json['clientStatusType'] as int),
      genderType: GenderType.fromCode(json['genderType'] as int),
      clientType: ClientType.fromCode(json['clientType'] as int),
      clientSourceType: ClientSource.fromCode(json['clientSourceType'] as int),

      clientExpectedMoveInDate: DateTime.parse(json['clientExpectedMoveInDate'] as String),
      clientExpectedTradeTypeList: (json['clientExpectedTradeTypeList'] as List)
          .map((e) => TransactionType.fromCode(e as int))
          .toList(),


      showingPropertyList: (json['showingPropertyList'] as List)
          .map((e) => ShowingPropertyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      clientScheduleList: (json['clientScheduleList'] as List)
          .map((e) => ClientScheduleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      clientRemarkList: (json['clientRemarkList'] as List)
          .map((e) => RemarkModel.fromJson(e as Map<String, dynamic>))
          .toList(), // 특이사항 리스트 변환
    );
  }
}


Map<String, dynamic> mockClientDetail = {
  "clientId": 1,
  "clientName": "홍길동",
  "clientPhoneNumber": "010-1234-5678",
  "picManagerName": "김매니저",
  "clientStatusType": 51, // 상담 중
  "genderType": 21, // 남성
  "clientType": 11, // 예: 특정 고객 타입 코드
  "clientSourceType": 31, // 예: 고객 소스 코드
  "clientExpectedMoveInDate": "2025-03-01 12:00",
  "clientExpectedTradeTypeList": [41, 42], // 매매, 전세

  // ShowingPropertyModel 데이터
  "showingPropertyList": [
    {
      "showingPropertyId": 1,
      "propertySellType": "매매",
      "propertyPrice": "5억 2000만 원",
      "propertyType": "아파트",
      "propertyAddress": "서울특별시 강남구 테헤란로 123",
    },
    {
      "showingPropertyId": 2,
      "propertySellType": "전세",
      "propertyPrice": "3억 원",
      "propertyType": "오피스텔",
      "propertyAddress": "경기도 성남시 분당구 판교로 45",
    },
    {
      "showingPropertyId": 3,
      "propertySellType": "월세",
      "propertyPrice": "5000만 / 100만 원",
      "propertyType": "빌라",
      "propertyAddress": "서울특별시 마포구 서교동 89-12",
    },
    {
      "showingPropertyId": 4,
      "propertySellType": "매매",
      "propertyPrice": "7억 원",
      "propertyType": "단독주택",
      "propertyAddress": "서울특별시 용산구 이태원로 77",
    },
    {
      "showingPropertyId": 5,
      "propertySellType": "전세",
      "propertyPrice": "2억 5000만 원",
      "propertyType": "아파트",
      "propertyAddress": "경기도 고양시 일산서구 대화동 202",
    }
  ],

  // ClientScheduleModel 데이터
  "clientScheduleList": [
    {
      "clientScheduleId": 1,
      "picManagerName": "이상훈",
      "clientScheduleDateTime": "2025-02-20 14:00",
      "clientScheduleType": "부동산 방문 상담",
      "clientScheduleRemark": "고객이 직접 방문하여 상담 진행 예정",
    },
    {
      "clientScheduleId": 2,
      "picManagerName": "박지연",
      "clientScheduleDateTime": "2025-02-22 10:30",
      "clientScheduleType": "매물 투어",
      "clientScheduleRemark": "강남구 지역 아파트 3곳 투어 일정",
    },
    {
      "clientScheduleId": 3,
      "picManagerName": "김민수",
      "clientScheduleDateTime": "2025-02-25 16:00",
      "clientScheduleType": "계약 상담",
      "clientScheduleRemark": "계약 조건 조율 및 계약서 검토 예정",
    }
  ],

  // RemarkModel 데이터
  "clientRemarkList": [
    {
      "remarkId": 1,
      "remark": "고객이 3월 중순까지 입주를 희망함.",
      "createdByUserId": 1,
      "createByUserName": "박성우",
      "createdBy": "부동산 매니저",
      "createdAt": DateTime.now(),
    },
    {
      "remarkId": 2,
      "remark": "예산 5억 원 이내로 매물을 찾고 있음.",
      "createdByUserId": 2,
      "createByUserName": "이현지",
      "createdBy": "부동산 컨설턴트",
      "createdAt": DateTime.now(),
    },
    {
      "remarkId": 3,
      "remark": "거래 방식은 전세 또는 매매를 고려 중.",
      "createdByUserId": 3,
      "createByUserName": "김재현",
      "createdBy": "팀장",
      "createdAt": DateTime.now(),
    },
    {
      "remarkId": 4,
      "remark": "교통이 편리한 지역을 선호함.",
      "createdByUserId": 4,
      "createByUserName": "송미나",
      "createdBy": "부동산 컨설턴트",
      "createdAt": DateTime.now(),
    }
  ]
};
