class ClientSummaryItem {
  final int clientId;
  final String picManagerName;
  final String clientName;
  final String clientStatus;
  final String clientPhoneNumber;
  final String clientSourceLabel;
  final String clientExpectedMoveInDate;

  ClientSummaryItem({
    required this.clientId,
    required this.picManagerName,
    required this.clientName,
    required this.clientStatus,
    required this.clientPhoneNumber,
    required this.clientSourceLabel,
    required this.clientExpectedMoveInDate,
  });

  // JSON으로부터 생성
  factory ClientSummaryItem.fromJson(Map<String, dynamic> json) {
    return ClientSummaryItem(
      clientId: json['clientId'],
      picManagerName: json['picManagerName'],
      clientName: json['clientName'],
      clientStatus: json['clientStatus'],
      clientPhoneNumber: json['clientPhoneNumber'],
      clientSourceLabel: json['clientSourceLabel'],
      clientExpectedMoveInDate: json['clientExpectedMoveInDate'],
    );
  }
}

List<ClientSummaryItem> mockClientSummaryItems = [
  ClientSummaryItem(
    clientId: 1,
    picManagerName: "김매니저1",
    clientName: "홍길동1",
    clientStatus: "상담중",
    clientPhoneNumber: "010-1234-5670",
    clientSourceLabel: "피터팬",
    clientExpectedMoveInDate: "2025-03-10",
  ),
  ClientSummaryItem(
    clientId: 2,
    picManagerName: "김매니저2",
    clientName: "홍길동2",
    clientStatus: "계약 예정",
    clientPhoneNumber: "010-1234-5671",
    clientSourceLabel: "직방",
    clientExpectedMoveInDate: "2025-03-10",
  ),
  ClientSummaryItem(
    clientId: 3,
    picManagerName: "김매니저3",
    clientName: "홍길동3",
    clientStatus: "계약 완료",
    clientPhoneNumber: "010-1234-5672",
    clientSourceLabel: "다방",
    clientExpectedMoveInDate: "2025-03-10",
  ),
  ClientSummaryItem(
    clientId: 4,
    picManagerName: "김매니저4",
    clientName: "홍길동4",
    clientStatus: "계약 완료",
    clientPhoneNumber: "010-1234-5673",
    clientSourceLabel: "다방",
    clientExpectedMoveInDate: "2025-03-10",
  ),
  ClientSummaryItem(
    clientId: 5,
    picManagerName: "김매니저5",
    clientName: "홍길동5",
    clientStatus: "입주 예정",
    clientPhoneNumber: "010-1234-5674",
    clientSourceLabel: "다방",
    clientExpectedMoveInDate: "2025-03-10",
  ),
  ClientSummaryItem(
    clientId: 6,
    picManagerName: "김매니저6",
    clientName: "홍길동6",
    clientStatus: "계약 완료",
    clientPhoneNumber: "010-1234-5675",
    clientSourceLabel: "다방",
    clientExpectedMoveInDate: "2025-03-10",
  ),
  ClientSummaryItem(
    clientId: 7,
    picManagerName: "김매니저7",
    clientName: "홍길동7",
    clientStatus: "상담중",
    clientPhoneNumber: "010-1234-5676",
    clientSourceLabel: "다방",
    clientExpectedMoveInDate: "2025-03-10",
  ),
  ClientSummaryItem(
    clientId: 8,
    picManagerName: "김매니저8",
    clientName: "홍길동8",
    clientStatus: "상담중",
    clientPhoneNumber: "010-1234-5677",
    clientSourceLabel: "다방",
    clientExpectedMoveInDate: "2025-03-10",
  ),
  ClientSummaryItem(
    clientId: 9,
    picManagerName: "김매니저9",
    clientName: "홍길동9",
    clientStatus: "계약 완료",
    clientPhoneNumber: "010-1234-5678",
    clientSourceLabel: "다방",
    clientExpectedMoveInDate: "2025-03-10",
  ),
  ClientSummaryItem(
    clientId: 10,
    picManagerName: "김매니저10",
    clientName: "홍길동10",
    clientStatus: "상담중",
    clientPhoneNumber: "010-1234-5679",
    clientSourceLabel: "다방",
    clientExpectedMoveInDate: "2025-03-10",
  ),
];
