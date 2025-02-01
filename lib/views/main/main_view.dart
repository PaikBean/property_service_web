import 'package:flutter/material.dart';
import 'package:property_service_web/core/enums/main_screen_type.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // 현재 활성화된 화면의 상태를 저장
  MainScreenType activeScreen = MainScreenType.DashBoard;

  // 상태 변경을 관리하는 함수
  void updateActiveScreen(MainScreenType screen) {
    setState(() {
      activeScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/silhouette-skyline-illustration/78786.jpg'),
            fit: BoxFit.cover,
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
                    width: 224,
                    color: Colors.white,
                    child: ListView(
                      children: [
                        SizedBox(height: 16),
                        _buildMenuItem(
                          title: MainScreenType.DashBoard.name,
                          depth: 0,
                          icon: Icons.dashboard,
                          onTap: () => updateActiveScreen(MainScreenType.DashBoard),
                        ),
                        _buildMenuItem(
                          title: MainScreenType.MyInfo.name,
                          depth: 0,
                          icon: Icons.person,
                          onTap: () => updateActiveScreen(MainScreenType.MyInfo),
                        ),
                        _buildMenuItem(
                          title: MainScreenType.CompanyInfo.name,
                          depth: 0,
                          icon: Icons.group,
                          onTap: () => updateActiveScreen(MainScreenType.CompanyInfo),
                        ),
                        _buildExpansionMenu(
                          title: "매출 장부",
                          depth: 0,
                          icon: Icons.attach_money,
                          children: [
                            _buildMenuItem(
                              title: MainScreenType.RevenueList.name,
                              depth: 1,
                              onTap: () => updateActiveScreen(MainScreenType.RevenueList),
                            ),
                            _buildMenuItem(
                              title: MainScreenType.RevenueRegsiter.name,
                              depth: 1,
                              onTap: () => updateActiveScreen(MainScreenType.RevenueRegsiter),
                            ),
                          ],
                        ),
                        _buildExpansionMenu(
                          title: "영업 장부",
                          depth: 0,
                          icon: Icons.real_estate_agent,
                          children: [
                            _buildMenuItem(
                              title: MainScreenType.SalesBuildingList.name,
                              depth: 1,
                              onTap: () => updateActiveScreen(MainScreenType.SalesBuildingList),
                            ),
                            _buildMenuItem(
                              title: MainScreenType.SalesPropertyRegister.name,
                              depth: 1,
                              onTap: () => updateActiveScreen(MainScreenType.SalesPropertyRegister),
                            ),
                            _buildMenuItem(
                              title: MainScreenType.SalesBuildingRegister.name,
                              depth: 1,
                              onTap: () => updateActiveScreen(MainScreenType.SalesBuildingRegister),
                            ),
                          ],
                        ),
                        _buildExpansionMenu(
                          title: "고객 장부",
                          depth: 0,
                          icon: Icons.group,
                          children: [
                            _buildMenuItem(
                              title: MainScreenType.ClientList.name,
                              depth: 1,
                              onTap: () => updateActiveScreen(MainScreenType.ClientList),
                            ),
                            _buildMenuItem(
                              title: MainScreenType.ClientRegister.name,
                              depth: 1,
                              onTap: () => updateActiveScreen(MainScreenType.ClientRegister),
                            ),
                          ],
                        ),
                        _buildMenuItem(
                          title: MainScreenType.Calendar.name,
                          depth: 0,
                          icon: Icons.calendar_month,
                          onTap: () => updateActiveScreen(MainScreenType.Calendar),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                  // 본문 영역
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Container(
                      width: size.width - 240,
                      height: size.height - 80,
                      color: Colors.white.withAlpha(236),
                      child: activeScreen.screen, // 현재 활성화된 화면 출력
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

  Widget _buildMenuItem({
    required String title,
    required int depth,
    IconData? icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0 * depth),
      child: ListTile(
        leading: icon != null ? Icon(icon, size: 20) : null,
        title: Text(title),
        onTap: onTap,
      ),
    );
  }

  Widget _buildExpansionMenu({
    required String title,
    required int depth,
    IconData? icon,
    required List<Widget> children,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0 * depth),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: icon != null ? Icon(icon, size: 20) : null,
          title: Text(title),
          children: children,
          // 색상 관련 속성 설정
          collapsedBackgroundColor: Colors.transparent, // 닫혔을 때 배경 색상
          backgroundColor: Colors.transparent, // 열렸을 때 배경 색상
          textColor: Colors.black, // 열렸을 때 텍스트 색상
          collapsedTextColor: Colors.black, // 닫혔을 때 텍스트 색상
          iconColor: Colors.black, // 열렸을 때 아이콘 색상
          collapsedIconColor: Colors.black, // 닫혔을 때 아이콘 색상
        ),
      ),
    );
  }
}
