import 'package:flutter/material.dart';
import 'package:kpostal_web/kpostal_web.dart';
import 'package:property_service_web/core/utils/custom_kakao_address_widget.dart';

class DialogUtils {
  /// 경고 메시지를 보여주는 다이얼로그
  static Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = "확인",
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 테두리 둥근 정도
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16, // 제목 글자 크기
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14, // 내용 글자 크기
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(Colors.transparent), // hover 효과 제거
              ),
              child: Text(
                confirmText,
                style: const TextStyle(
                  fontSize: 14, // 버튼 글자 크기
                  fontWeight: FontWeight.w600,
                  color: Colors.black
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 확인 메시지를 보여주는 다이얼로그
  static Future<bool> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = "확인",
    String cancelText = "취소",
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 테두리 둥근 정도
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16, // 제목 글자 크기
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14, // 내용 글자 크기
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // "취소" 선택 시 false 반환
              },
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(Colors.transparent), // hover 효과 제거
              ),
              child: Text(
                cancelText,
                style: const TextStyle(
                  fontSize: 14, // 버튼 글자 크기
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // "확인" 선택 시 true 반환
              },
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(Colors.transparent), // hover 효과 제거
              ),
              child: Text(
                confirmText,
                style: const TextStyle(
                  fontSize: 14, // 버튼 글자 크기
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  static Future<KakaoAddress?> showAddressSearchDialog({
    required BuildContext context,
  }) async {
    bool isPopped = false; // 다이얼로그가 닫혔는지 확인하는 플래그

    return await showDialog<KakaoAddress>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            width: 480,
            height: 640,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "주소찾기",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (!isPopped) {
                          isPopped = true;
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        }
                      },
                      icon: Icon(
                        Icons.close,
                        size: 32,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Stack(
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      SingleChildScrollView(
                        child: CustomKakaoAddressWidget(
                          onComplete: (KakaoAddress kakaoAddress) {
                            if (!isPopped) {
                              Navigator.of(context).pop(kakaoAddress); // 주소 데이터를 반환하며 다이얼로그 닫기
                              isPopped = true;
                            }
                          },
                          onClose: () {
                            if (!isPopped) {
                              Navigator.of(context).pop(); // 다이얼로그 닫기
                              isPopped = true;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
