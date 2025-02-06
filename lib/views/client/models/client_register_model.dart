import '../../../core/enums/gender_type.dart';
import '../../../core/enums/transaction_type.dart';
import '../enums/client_source_type.dart';
import '../enums/client_type_code.dart';

class ClientRegisterModel {
  final String clientName;
  final String clientPhoneNumber;
  final GenderType clientGender;
  final ClientType clientType;
  final String clientTypeOther;
  final ClientSource clientSource;
  final String clientSourceOther;
  final DateTime clientExpectedMoveInDate;
  final List<TransactionType> clientExpectedTradeTypeList;
  final String clientRemark;

  ClientRegisterModel({
    required this.clientName,
    required this.clientPhoneNumber,
    required this.clientGender,
    required this.clientType,
    required this.clientTypeOther,
    required this.clientSource,
    required this.clientSourceOther,
    required this.clientExpectedMoveInDate,
    required this.clientExpectedTradeTypeList,
    required this.clientRemark,
  });

  // JSON으로부터 생성
  factory ClientRegisterModel.fromJson(Map<String, dynamic> json) {
    return ClientRegisterModel(
      clientName: json['clientName'],
      clientPhoneNumber: json['clientPhoneNumber'],
      clientGender: GenderType.fromCode(json['clientGenderCode']),
      clientType: ClientType.fromCode(json['clientTypeCode']),
      clientTypeOther: json['clientTypeOther'],
      clientSource: ClientSource.fromCode(json['clientSourceCode']),
      clientSourceOther: json['clientSourceOther'],
      clientExpectedMoveInDate: DateTime.parse(json['clientExpectedMoveInDate']),
      clientExpectedTradeTypeList: (json['clientExpectedTradeTypeList'] as List)
          .map((code) => TransactionType.fromCode(code))
          .toList(), // 코드 값 리스트를 TransactionType Enum 리스트로 변환
      clientRemark: json['clientRemark'],
    );
  }


  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'clientName': clientName,
      'clientPhoneNumber': clientPhoneNumber,
      'clientGenderCode': clientGender.code,
      'clientTypeCode': clientType.code,
      'clientTypeOther': clientTypeOther,
      'clientSourceCode': clientSource.code, // 코드 저장
      'clientSourceOther': clientSourceOther,
      'clientExpectedMoveInDate': clientExpectedMoveInDate.toIso8601String(),
      'clientExpectedTradeTypeList': clientExpectedTradeTypeList.map((e) => e.code).toList(),
      'clientRemark': clientRemark,
    };
  }
}
