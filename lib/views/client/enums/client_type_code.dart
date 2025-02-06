enum ClientType {
  blank("", 10),
  student("학생", 11),
  worker("직장인", 12),
  foreigner("외국인", 13),
  other("기타", 14);

  final String label; // 한국어 라벨
  final int code;     // 코드 값

  const ClientType(this.label, this.code);

  // 코드로부터 Enum 객체를 찾는 메서드
  static ClientType fromCode(int code) {
    return ClientType.values.firstWhere(
          (e) => e.code == code,
      orElse: () => ClientType.blank,
    );
  }

  // 라벨로부터 Enum 객체를 찾는 메서드
  static ClientType fromLabel(String label) {
    return ClientType.values.firstWhere(
          (e) => e.label == label,
      orElse: () => ClientType.blank,
    );
  }
}
