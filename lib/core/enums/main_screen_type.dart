import 'package:flutter/cupertino.dart';
import 'package:property_service_web/views/calendar/calendar_view.dart';
import 'package:property_service_web/views/client/client_list_view.dart';
import 'package:property_service_web/views/client/client_register_view.dart';
import 'package:property_service_web/views/company/company_info_view.dart';
import 'package:property_service_web/views/myinfo/my_info_view.dart';
import 'package:property_service_web/views/revenue/revenue_list_view.dart';
import 'package:property_service_web/views/revenue/revenue_register_view.dart';
import 'package:property_service_web/views/sales/sales_building_list_view.dart';
import 'package:property_service_web/views/sales/sales_building_register_view.dart';
import 'package:property_service_web/views/sales/sales_property_detail_view.dart';
import 'package:property_service_web/views/sales/sales_property_register_view.dart';

enum MainScreenType {
  DashBoard,
  MyInfo,
  CompanyInfo,
  RevenueList,
  RevenueRegsiter,
  SalesBuildingList,
  SalesPropertyDetail,
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
      case MainScreenType.RevenueRegsiter:
        return "매출 등록";
      case MainScreenType.SalesBuildingList:
        return "매물 목록";
      case MainScreenType.SalesPropertyDetail:
        return "매물 상세";
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
      case MainScreenType.RevenueRegsiter:
        return "매출 등록";
      case MainScreenType.SalesBuildingList:
        return "매물 목록";
      case MainScreenType.SalesPropertyDetail:
        return "매물 상세";
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
        return Container();
      case MainScreenType.MyInfo:
        return MyInfoView();
      case MainScreenType.CompanyInfo:
        return CompanyInfoView();
      case MainScreenType.RevenueList:
        return RevenueListView();
      case MainScreenType.RevenueRegsiter:
        return RevenueRegisterView();
      case MainScreenType.SalesBuildingList:
        return SalesBuildingListView();
      case MainScreenType.SalesPropertyDetail:
        return SalesPropertyDetailView();
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
