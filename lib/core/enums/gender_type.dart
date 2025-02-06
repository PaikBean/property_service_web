enum GenderType {
  blank("", 20),
  male("남성", 21),
  female("여성", 22);

  final String label; // 한국어 라벨
  final int code;     // 코드 값

  const GenderType(this.label, this.code);

  // 코드 값으로 GenderCode Enum 찾기
  static GenderType fromCode(int code) {
    return GenderType.values.firstWhere(
          (e) => e.code == code,
      orElse: () => GenderType.blank, // 기본값: 남성
    );
  }

  // 라벨 값으로 GenderCode Enum 찾기
  static GenderType fromLabel(String label) {
    return GenderType.values.firstWhere(
          (e) => e.label == label,
      orElse: () => GenderType.blank,
    );
  }
}
