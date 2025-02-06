enum ScheduleType {
  blank("", 50),
  consulting("상담", 61),
  contract("계약", 62),
  moveIn("입주", 63);

  final String label; // 한국어 라벨
  final int code;     // 코드 값

  const ScheduleType(this.label, this.code);

  // 코드 값으로 Enum 찾기
  static ScheduleType fromCode(int code) {
    return ScheduleType.values.firstWhere(
          (e) => e.code == code,
      orElse: () => ScheduleType.blank,
    );
  }

  // 라벨 값으로 Enum 찾기
  static ScheduleType fromLabel(String label) {
    return ScheduleType.values.firstWhere(
          (e) => e.label == label,
      orElse: () => ScheduleType.blank,
    );
  }
}
