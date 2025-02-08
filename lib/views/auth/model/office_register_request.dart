class OfficeRegisterRequest {
  final String officeName;
  final String zoneCode;
  final String officeAddress;
  final String addressDetail;
  final String presidentName;
  final String presidentEmail;
  final String mobileNumber;
  final String phoneNumber;

  OfficeRegisterRequest({
    required this.officeName,
    required this.zoneCode,
    required this.officeAddress,
    required this.addressDetail,
    required this.presidentName,
    required this.presidentEmail,
    required this.mobileNumber,
    required this.phoneNumber,
  });

  /// JSON 데이터를 객체로 변환하는 factory 메서드
  factory OfficeRegisterRequest.fromJson(Map<String, dynamic> json) {
    return OfficeRegisterRequest(
      officeName: json['officeName'] ?? '',
      zoneCode: json['zoneCode'] ?? '',
      officeAddress: json['officeAddress'] ?? '',
      addressDetail: json['addressDetail'],
      presidentName: json['presidentName'],
      presidentEmail: json['presidentEmail'] ?? '',
      mobileNumber: json['mobileNumber'],
      phoneNumber: json['phoneNumber'],
    );
  }

  /// 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'officeName': officeName,
      'zoneCode': zoneCode,
      'officeAddress': officeAddress,
      'addressDetail': addressDetail,
      'presidentName': presidentName,
      'presidentEmail': presidentEmail,
      'mobileNumber': mobileNumber,
      'phoneNumber': phoneNumber,
    };
  }
}
