import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/silhouette-skyline-illustration/78786.jpg'), // 이미지 경로
            fit: BoxFit.cover, // 이미지 맞춤 옵션
          ),
        ),
        child: Column(
          children: [
            // 상단 네비게이션 바
            Container(
              height: 64,
              color: Color(0xFF728989),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Property Service",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[200],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.logout),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            // 본문 내용
            Expanded(
              child: Row(
                children: [
                  // 메뉴 영역
                  Container(
                    width: 200,
                    color: Colors.white,
                    child: ListView(
                      children: [
                        SizedBox(height: 16),
                        _buildMenuItem(
                          title: "마이 페이지",
                          depth: 0,
                          icon: Icons.settings_accessibility,
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          title: "조직 관리",
                          depth: 0,
                          icon: Icons.corporate_fare,
                          onTap: () {},
                        ),
                        _buildExpansionMenu(
                          title: "매출 장부",
                          depth: 0,
                          icon: Icons.real_estate_agent,
                          children: [
                            _buildMenuItem(
                              title: "매출 장부 목록",
                              depth: 1,
                              onTap: () {},
                            ),
                            _buildMenuItem(
                              title: "매출 장부 등록",
                              depth: 1,
                              onTap: () {},
                            ),
                          ],
                        ),
                        _buildExpansionMenu(
                          title: "영업 장부",
                          depth: 0,
                          icon: Icons.holiday_village,
                          children: [
                            _buildMenuItem(title: "매물 목록", depth: 1, onTap: () {}),
                            _buildMenuItem(title: "매물 등록", depth: 1, onTap: () {}),
                            _buildMenuItem(
                              title: "건물/임대인 등록",
                              depth: 1,
                              onTap: () {},
                            ),
                          ],
                        ),
                        _buildExpansionMenu(
                          title: "고객 장부",
                          depth: 0,
                          icon: Icons.people,
                          children: [
                            _buildMenuItem(title: "고객 목록", depth: 1, onTap: () {}),
                            _buildMenuItem(title: "고객 등록", depth: 1, onTap: () {}),
                          ],
                        ),
                        _buildMenuItem(
                          title: "캘린더",
                          depth: 0,
                          icon: Icons.calendar_month,
                          onTap: () {},
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),

                  // 본문 내용 영역 (스크롤 가능)
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Container(
                        width: size.width - 216,
                        height: size.height - 80,
                        color: Colors.white.withAlpha(196),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical, // 수직 스크롤
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal, // 수평 스크롤
                            // child: Row(
                            //   children: List.generate(
                            //       20,
                            //           (index) => Text(
                            //         "메인 컨텐츠 영역  동적 크기$index)",
                            //         style: TextStyle(
                            //           fontSize: 18,
                            //           fontWeight: FontWeight.w500,
                            //         ),
                            //       ),
                            //   ),
                            // ),
                            child: Container(
                              child: Column(
                                children: [
                                  Text("매출 장부"),
                                  SizedBox(height: 16),
                                  Text("컬럼1"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 일반 메뉴 항목 생성
  Widget _buildMenuItem({
    required String title,
    required int depth,
    IconData? icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0 * depth), // Depth에 따라 들여쓰기
      child: ListTile(
        leading: icon != null ? Icon(icon, size: 20) : null, // 아이콘 추가
        title: Text(title),
        onTap: onTap,
      ),
    );
  }

  /// 확장 가능한 메뉴 생성
  Widget _buildExpansionMenu({
    required String title,
    required int depth,
    IconData? icon,
    required List<Widget> children,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0 * depth), // Depth에 따라 들여쓰기
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: icon != null ? Icon(icon, size: 20) : null, // 아이콘 추가
          title: Text(title),
          children: children,
        ),
      ),
    );
  }
}
