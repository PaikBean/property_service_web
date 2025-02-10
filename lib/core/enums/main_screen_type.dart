import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:property_service_web/views/calendar/calendar_view.dart';
import 'package:property_service_web/views/client/client_list_view.dart';
import 'package:property_service_web/views/client/client_register_view.dart';
import 'package:property_service_web/views/company/company_info_view.dart';
import 'package:property_service_web/views/myinfo/my_info_view.dart';
import 'package:property_service_web/views/revenue/revenue_list_view.dart';
import 'package:property_service_web/views/revenue/revenue_register_view.dart';
import 'package:property_service_web/views/sales/sales_property_list_view.dart';
import 'package:property_service_web/views/sales/sales_building_register_view.dart';
import 'package:property_service_web/views/sales/sales_property_register_view.dart';

enum MainScreenType {
  DashBoard,
  MyInfo,
  CompanyInfo,
  RevenueList,
  // RevenueRegsiter,   // todo 영업 매출 실적 탭으로 대체
  SalesPropertyList,
  SalesPropertyRegister,
  SalesBuildingRegister,
  ClientList,
  ClientRegister,
  Calendar,
}

extension MainScreenTypeExtension on MainScreenType {
  String get name {
    switch (this) {
      case MainScreenType.DashBoard:
        return "대시보드";
      case MainScreenType.MyInfo:
        return "나의 정보";
      case MainScreenType.CompanyInfo:
        return "조직 정보";
      case MainScreenType.RevenueList:
        return "매출 목록";
      // case MainScreenType.RevenueRegsiter:   // todo 영업 매출 실적 탭으로 대체
      //   return "매출 등록";
      case MainScreenType.SalesPropertyList:
        return "매물 목록";
      case MainScreenType.SalesPropertyRegister:
        return "매물 등록";
      case MainScreenType.SalesBuildingRegister:
        return "건물 등록";
      case MainScreenType.ClientList:
        return "고객 목록";
      case MainScreenType.ClientRegister:
        return "고객 등록";
      case MainScreenType.Calendar:
        return "캘린더";
      }
  }

  String get description {
    switch (this) {
      case MainScreenType.DashBoard:
        return "대시보드";
      case MainScreenType.MyInfo:
        return "나의 정보";
      case MainScreenType.CompanyInfo:
        return "조직 정보";
      case MainScreenType.RevenueList:
        return "매출 목록";
      // case MainScreenType.RevenueRegsiter:   // todo 영업 매출 실적 탭으로 대체
      //   return "매출 등록";
      case MainScreenType.SalesPropertyList:
        return "매물 목록";
      case MainScreenType.SalesPropertyRegister:
        return "매물 등록";
      case MainScreenType.SalesBuildingRegister:
        return "건물 등록";
      case MainScreenType.ClientList:
        return "고객 목록";
      case MainScreenType.ClientRegister:
        return "고객 등록";
      case MainScreenType.Calendar:
        return "캘린더";
    }
  }

  Widget get screen {
    switch (this) {
      case MainScreenType.DashBoard:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Property Service",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF728989),
                ),
              ),
              SizedBox(height: 48),
              Text(
                "대시보드는 현재 개발 중 입니다.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF9baaa6),
                ),
              ),
              // SizedBox(height: 24),
              // Text(
              //   "기타 문의사항은 관리자에게 문의해 주세요.",
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w700,
              //     color: Color(0xFF9baaa6),
              //   ),
              // ),
            ],
          ),
        );
      case MainScreenType.MyInfo:
        return MyInfoView();
      case MainScreenType.CompanyInfo:
        return CompanyInfoView();
      case MainScreenType.RevenueList:
        return RevenueListView();
      // case MainScreenType.RevenueRegsiter:   // todo 영업 매출 실적 탭으로 대체
      //   return RevenueRegisterView();
      case MainScreenType.SalesPropertyList:
        return SalesPropertyListView();
      case MainScreenType.SalesPropertyRegister:
        return SalesPropertyRegisterView();
      case MainScreenType.SalesBuildingRegister:
        return SalesBuildingRegisterView();
      case MainScreenType.ClientList:
        return ClientListView();
      case MainScreenType.ClientRegister:
        return ClientRegisterView();
      case MainScreenType.Calendar:
        return CalendarView();
    }
  }
}
