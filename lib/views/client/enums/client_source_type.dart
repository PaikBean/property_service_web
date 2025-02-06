enum ClientSource {
  blank("", 30),
  zigbang("직방", 31),
  dabang("다방", 32),
  peterpan("피터팬", 33),
  walking("워킹", 34),
  other("기타", 35);

  final String label; // 한국어 라벨
  final int code;     // 코드 값

  const ClientSource(this.label, this.code);

  // 코드 값으로 Enum 찾기
  static ClientSource fromCode(int code) {
    return ClientSource.values.firstWhere(
          (e) => e.code == code,
      orElse: () => ClientSource.blank,
    );
  }

  // 라벨 값으로 Enum 찾기
  static ClientSource fromLabel(String label) {
    return ClientSource.values.firstWhere(
          (e) => e.label == label,
      orElse: () => ClientSource.blank,
    );
  }
}
