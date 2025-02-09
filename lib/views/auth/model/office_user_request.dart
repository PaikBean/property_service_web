class OfficeUserRequest {
  final String officeCode;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;

  OfficeUserRequest({
    required this.officeCode,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  /// JSON 데이터를 객체로 변환하는 factory 메서드
  factory OfficeUserRequest.fromJson(Map<String, dynamic> json) {
    return OfficeUserRequest(
      officeCode: json['officeCode'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'],
      phoneNumber: json['phoneNumber'],
    );
  }

  /// 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'officeCode': officeCode,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }
}
