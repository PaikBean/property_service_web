class RemarkAddRequest {
  final String remark;

  RemarkAddRequest({
    required this.remark,
  });

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'remark': remark,
    };
  }
}
