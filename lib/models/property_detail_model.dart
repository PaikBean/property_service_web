class PropertyDetailModel {
  final int id;
  final String transactionType;
  final String price;
  final String address;

  final String propertyOwner;
  final String propertyOwnerPhoneNumber;
  final String propertyOwnerRelation;

  final String propertyManager;
  final String propertyStatus;

  final String propertyType;

  // 건물 id
  // 건물 주소

  // 매물 id
  // 매물 상태
  // 매물 담당자

  // 임대인 이름
  // 임대인 전화번호
  // 임대인 관계

  // 건물 이름
  // 매물 주소
  // 해당층 / 전체 층
  // 방 욕실 개수
  // 주 실 기준 방향
  // 전용 공급 면적
  // 사용 승인일
  // 입주 가능일

  // 매물 거래 유형 1, 2, 3, 4
  // 매물 가격 1, 2, 3, 4,

  // 관리비
  // 관리비 항목
  // 주차 가능 대수
  // 난방 방식
  // 옵션
  // 매물 사진 목록

  PropertyDetailModel({
    required this.photo,
  });
}
