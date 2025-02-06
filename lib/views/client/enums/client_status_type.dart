enum ClientStatusType {
  blank("", 50),
  consulting("상담 중", 51),
  contractScheduled("계약 예정", 52),
  moveInScheduled("입주 예정", 53),
  contractCompleted("계약 완료", 54);

  final String label; // 한국어 라벨
  final int code;     // 코드 값

  const ClientStatusType(this.label, this.code);

  // 코드 값으로 Enum 찾기
  static ClientStatusType fromCode(int code) {
    return ClientStatusType.values.firstWhere(
          (e) => e.code == code,
      orElse: () => ClientStatusType.blank,
    );
  }

  // 라벨 값으로 Enum 찾기
  static ClientStatusType fromLabel(String label) {
    return ClientStatusType.values.firstWhere(
          (e) => e.label == label,
      orElse: () => ClientStatusType.blank,
    );
  }
}
