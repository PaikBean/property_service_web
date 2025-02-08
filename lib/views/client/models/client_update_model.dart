import '../../../core/enums/transaction_type.dart';
import '../enums/client_source_type.dart';
import '../enums/client_type_code.dart';

class ClientUpdateModel {
  final int clientId;

  final String clientName;
  final String clientPhoneNumber;
  final String picManagerName;

  final ClientType clientType;
  final String? clientTypeOther;

  final ClientSource clientSourceType;
  final String? clientSourceTypeOther;

  final DateTime clientExpectedMoveInDate;
  final List<TransactionType> clientExpectedTradeTypeList;

  ClientUpdateModel({
    required this.clientId,
    required this.clientName,
    required this.clientPhoneNumber,
    required this.picManagerName,
    required this.clientType,
    this.clientTypeOther,
    required this.clientSourceType,
    this.clientSourceTypeOther,
    required this.clientExpectedMoveInDate,
    required this.clientExpectedTradeTypeList,

  });

  // JSON으로부터 생성
  factory ClientUpdateModel.fromJson(Map<String, dynamic> json) {
    return ClientUpdateModel(
      clientId: json['clientId'] as int,
      clientName: json['clientName'] as String,
      clientPhoneNumber: json['clientPhoneNumber'] as String,
      picManagerName: json['picManagerName'] as String,
      clientType: ClientType.fromCode(json['clientType'] as int),
      clientTypeOther: json['clientTypeOther'] as String?,
      clientSourceType: ClientSource.fromCode(json['clientSourceType'] as int),
      clientSourceTypeOther: json['clientSourceTypeOther'] as String?,
      clientExpectedMoveInDate: DateTime.parse(json['clientExpectedMoveInDate'] as String),
      clientExpectedTradeTypeList: (json['clientExpectedTradeTypeList'] as List)
          .map((code) => TransactionType.fromCode(code as int))
          .toList(),
    );
  }

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'clientName': clientName,
      'clientPhoneNumber': clientPhoneNumber,
      'picManagerName': picManagerName,
      'clientType': clientType.code,
      'clientTypeOther': clientTypeOther,
      'clientSourceType': clientSourceType.code,
      'clientSourceTypeOther': clientSourceTypeOther,
      'clientExpectedMoveInDate': clientExpectedMoveInDate.toIso8601String(),
      'clientExpectedTradeTypeList': clientExpectedTradeTypeList.map((e) => e.code).toList(),
    };
  }
}
