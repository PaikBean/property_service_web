enum TransactionType {
  blank("", 40),
  monthly("월세", 41),
  jeonse("전세", 42),
  // sale("매매", 43),
  shortTerm("단기", 44),
  ;

  final String label; // 한국어 라벨
  final int code;     // 코드 값

  const TransactionType(this.label, this.code);

  static TransactionType fromCode(int code) {
    return TransactionType.values.firstWhere(
          (e) => e.code == code,
      orElse: () => TransactionType.blank,
    );
  }

  static TransactionType fromLabel(String label) {
    return TransactionType.values.firstWhere(
          (e) => e.label == label,
      orElse: () => TransactionType.blank,
    );
  }

}
