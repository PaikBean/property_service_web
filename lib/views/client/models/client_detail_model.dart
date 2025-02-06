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
  "clientExpectedMoveInDate": "2025-03-01T12:00:00Z",
  "clientExpectedTradeTypeList": [41, 42], // 매매, 전세

  // ShowingPropertyModel 임시 데이터
  "showingPropertyList": [
    {
      "showingPropertyId" : 1,
      "propertySellType" : "임시데이터",
      "propertyPrice" : "임시데이터",
      "propertyType" : "임시데이터",
      "propertyAddress" : "임시데이터",
    },
    {
      "showingPropertyId" : 2,
      "propertySellType" : "임시데이터",
      "propertyPrice" : "임시데이터",
      "propertyType" : "임시데이터",
      "propertyAddress" : "임시데이터",
    },
  ],

  // ClientScheduleModel 임시 데이터
  "clientScheduleList": [
    {
      "clientScheduleId": 1,
      "picManagerName": "임시 데이터",
      "clientScheduleDateTime": "임시 데이터",
      "clientScheduleType": "임시 데이터",
      "clientScheduleRemark": "임시 데이터",
    },
    {
      "clientScheduleId": 2,
      "picManagerName": "임시 데이터",
      "clientScheduleDateTime": "임시 데이터",
      "clientScheduleType": "임시 데이터",
      "clientScheduleRemark": "임시 데이터",
    },
    {
      "clientScheduleId": 3,
      "picManagerName": "임시 데이터",
      "clientScheduleDateTime": "임시 데이터",
      "clientScheduleType": "임시 데이터",
      "clientScheduleRemark": "임시 데이터",
    }
  ],

  // RemarkModel 임시 데이터
  "clientRemarkList": [
    {
      "clientRemarkId": 1,
      "clientRemark": "임시 데이터",
      "createdByUserId": 1,
      "createByUserName": "임시 데이터",
      "createdBy": "임시 데이터",
      "createdAt": DateTime.now(),
    },
    {
      "clientRemarkId": 2,
      "clientRemark": "임시 데이터",
      "createdByUserId": 1,
      "createByUserName": "임시 데이터",
      "createdBy": "임시 데이터",
      "createdAt": DateTime.now(),
    },
    {
      "clientRemarkId": 3,
      "clientRemark": "임시 데이터",
      "createdByUserId": 1,
      "createByUserName": "임시 데이터",
      "createdBy": "임시 데이터",
      "createdAt": DateTime.now(),
    },
    {
      "clientRemarkId": 4,
      "clientRemark": "임시 데이터",
      "createdByUserId": 1,
      "createByUserName": "임시 데이터",
      "createdBy": "임시 데이터",
      "createdAt": DateTime.now(),
    },
    {
      "clientRemarkId": 5,
      "clientRemark": "임시 데이터",
      "createdByUserId": 1,
      "createByUserName": "임시 데이터",
      "createdBy": "임시 데이터",
      "createdAt": DateTime.now(),
    },{
      "clientRemarkId": 6,
      "clientRemark": "임시 데이터",
      "createdByUserId": 1,
      "createByUserName": "임시 데이터",
      "createdBy": "임시 데이터",
      "createdAt": DateTime.now(),
    },
    {
      "clientRemarkId": 7,
      "clientRemark": "임시 데이터",
      "createdByUserId": 1,
      "createByUserName": "임시 데이터",
      "createdBy": "임시 데이터",
      "createdAt": DateTime.now(),
    },

  ]
};