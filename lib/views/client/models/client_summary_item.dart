class ClientSummaryItem {
  final int clientId;
  final String picManagerName;
  final String clientName;
  final String clientPhoneNumber;
  final String clientSourceLabel;
  final String clientExpectedMoveInDate;

  ClientSummaryItem({
    required this.clientId,
    required this.picManagerName,
    required this.clientName,
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
    clientPhoneNumber: "010-1234-5670",
    clientSourceLabel: "Source 1",
    clientExpectedMoveInDate: "2025-03-10T12:00:00Z",
  ),
  ClientSummaryItem(
    clientId: 2,
    picManagerName: "김매니저2",
    clientName: "홍길동2",
    clientPhoneNumber: "010-1234-5671",
    clientSourceLabel: "Source 2",
    clientExpectedMoveInDate: "2025-03-11T12:00:00Z",
  ),
  ClientSummaryItem(
    clientId: 3,
    picManagerName: "김매니저3",
    clientName: "홍길동3",
    clientPhoneNumber: "010-1234-5672",
    clientSourceLabel: "Source 3",
    clientExpectedMoveInDate: "2025-03-12T12:00:00Z",
  ),
  ClientSummaryItem(
    clientId: 4,
    picManagerName: "김매니저4",
    clientName: "홍길동4",
    clientPhoneNumber: "010-1234-5673",
    clientSourceLabel: "Source 1",
    clientExpectedMoveInDate: "2025-03-13T12:00:00Z",
  ),
  ClientSummaryItem(
    clientId: 5,
    picManagerName: "김매니저5",
    clientName: "홍길동5",
    clientPhoneNumber: "010-1234-5674",
    clientSourceLabel: "Source 2",
    clientExpectedMoveInDate: "2025-03-14T12:00:00Z",
  ),
  ClientSummaryItem(
    clientId: 6,
    picManagerName: "김매니저6",
    clientName: "홍길동6",
    clientPhoneNumber: "010-1234-5675",
    clientSourceLabel: "Source 3",
    clientExpectedMoveInDate: "2025-03-15T12:00:00Z",
  ),
  ClientSummaryItem(
    clientId: 7,
    picManagerName: "김매니저7",
    clientName: "홍길동7",
    clientPhoneNumber: "010-1234-5676",
    clientSourceLabel: "Source 1",
    clientExpectedMoveInDate: "2025-03-16T12:00:00Z",
  ),
  ClientSummaryItem(
    clientId: 8,
    picManagerName: "김매니저8",
    clientName: "홍길동8",
    clientPhoneNumber: "010-1234-5677",
    clientSourceLabel: "Source 2",
    clientExpectedMoveInDate: "2025-03-17T12:00:00Z",
  ),
  ClientSummaryItem(
    clientId: 9,
    picManagerName: "김매니저9",
    clientName: "홍길동9",
    clientPhoneNumber: "010-1234-5678",
    clientSourceLabel: "Source 3",
    clientExpectedMoveInDate: "2025-03-18T12:00:00Z",
  ),
  ClientSummaryItem(
    clientId: 10,
    picManagerName: "김매니저10",
    clientName: "홍길동10",
    clientPhoneNumber: "010-1234-5679",
    clientSourceLabel: "Source 1",
    clientExpectedMoveInDate: "2025-03-19T12:00:00Z",
  ),
];
