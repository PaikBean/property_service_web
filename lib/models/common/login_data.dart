import 'package:flutter/material.dart';

import '../model/JwtLoginData.dart';
import '../model/userDto.dart';

class LoginData with ChangeNotifier {
  double _width = 0.0;
  double _height = 0.0;

  bool _isWebMobile = false;
  bool _isWebMobileiOS = false;
  bool _isWebMobileAnd = false;

  bool isLinkFirst = true;

  /*********************[ 변수 - 외부진입 ]*******************/
  String _inType = "";
  String _inData1 = "";
  String _inData2 = "";

  /*********************[ 변수 - 회원가입 ]*******************/
  Map<String, dynamic> _dataList = {};

  /*********************[ 변수 - platform ]*******************/
  bool _isSett = false;
  bool _isWeb = false; // pc : true, native : false
  bool _isSSL = false;
  bool _isDev = false;
  String _serverUrl = 'lavidashop.co.kr';
  bool _iOS = false;
  bool _Android = false;

  /*********************[ 변수 - 공통 ]*******************/
  Map<String, dynamic> map; //
  // UserDto? session; // 로그인 세션정보
  JwtLogInData? session; // 로그인 세션정보

  String _loginSns = "";    // sns 로그인여부

  /*********************[ 공통 - 시작 ]*******************/
  // 초기화
  LoginData({
    required this.map,
    required this.session,
  });

  void logOut() {
    this.session = null;
    this._loginSns = "";
    this._inType = "";
    this._inData1 = "";
    this._inData2 = "";
    this.isLinkFirst = true;
  }

  double getWidth() => _width;

  double getHeight() => _height;

  void setWidth(double _w) {
    _width = _w;
    // notifyListeners();
  }

  void setHeight(double _h) {
    _height = _h;
    // notifyListeners();
  }

  // 사이트타입 가져오기
  bool isWebMobile() => _isWebMobile;

  bool isWebMobileiOS() => _isWebMobileiOS;

  bool isWebMobileAnd() => _isWebMobileAnd;

  // 사이트타입  저장하기
  void setIsWebMobile(bool _inData) {
    _isWebMobile = _inData;
    // notifyListeners();
  }

  void setIsWebMobileiOS(bool _inData) {
    _isWebMobileiOS = _inData;
    // notifyListeners();
  }

  void setIsWebMobileAnd(bool _inData) {
    _isWebMobileAnd = _inData;
    // notifyListeners();
  }

  // 외부진입 _intype 가져오기
  String getInType() => _inType;

  // 외부진입 _intype  저장하기
  void setInType(String _inData) {
    _inType = _inData;
    // notifyListeners();
  }

  // 외부진입 _intype 가져오기
  Map<String, String> getInDatas() => {"id1": _inData1, "id2": _inData2};

  // 외부진입 _intype  저장하기
  void setInDatas(String inData1, String inData2) {
    _inData1 = inData1;
    _inData2 = inData2;
    // notifyListeners();
  }

  // _loginSns 가져오기
  String getLoginSns() => _loginSns;

  // _loginSns  저장하기
  void setLoginSns(String _inData) {
    _loginSns = _inData;
    notifyListeners();
  }

  // dataList 가져오기
  Map<String, dynamic> getCertData() => _dataList;

  // dataList  저장하기
  void setCertData(Map<String, dynamic> _inData) {
    _dataList = _inData;
    notifyListeners();
  }

  // android 여부 가져오기
  bool isAndroid() => _Android;

  // android 여부  저장하기
  void setIsAndroid(bool _inData) {
    _Android = _inData;
    notifyListeners();
  }

  // ios 여부 가져오기
  bool isIOS() => _iOS;

  // ios 여부  저장하기
  void setIsIOS(bool _inData) {
    _iOS = _inData;
    // notifyListeners();
  }

  // web 여부 가져오기
  bool isWeb() => _isWeb;

  // web 여부  저장하기
  void setIsWeb(bool _inData) {
    _isWeb = _inData;
    // notifyListeners();
  }

  // ssl 여부 가져오기
  bool isSSL() => _isSSL;

  // ssl 여부  저장하기
  void setIsSSL(bool _inData) {
    _isSSL = _inData;
    // notifyListeners();
  }

  // 개발서버 여부 가져오기
  bool isDev() => _isDev;

  // 개발서버 여부  저장하기
  void setIsDev(bool _inData) {
    _isDev = _inData;
    // notifyListeners();
  }

  // serverUrl 주소 가져오기
  String serverUrl() => _serverUrl;

  // serverUrl 주소  저장하기
  void setServerUrl(String _inData) {
    _serverUrl = _inData;
    // notifyListeners();
  }

  // 초기 셋팅 여부
  bool isSett() => _isSett;

  // 초기 셋팅 여부
  void setIsSett(bool _inData) {
    _isSett = _inData;
    // notifyListeners();
  }

  // map 가져오기
  Map<String, dynamic> getMap() => map;

  // map 저장하기
  void setMap(Map<String, dynamic> _map) {
    map = _map;
    notifyListeners();
  }

  // 세션 가져오기
  JwtLogInData? getSession() => session;

  // 세션 저장하기
  void setSession(JwtLogInData _sessionObj) {
    session = _sessionObj;
    notifyListeners();
  }

  void updateSessionCenter(String newCenterCd, String newCenterName) {
    if (session != null) {
      session!.updateUserInfoCenter(newCenterCd, newCenterName);
      notifyListeners(); // 변경 알림
    } else {
      throw Exception("LoginData가 설정되지 않았습니다.");
    }
  }

// 세션 가져오기
// UserDto? getSession() => session == null ? null : session!;

// 세션 저장하기
// void setSession(UserDto _sessionObj) {
//   session = _sessionObj;
//   notifyListeners();
// }

}
