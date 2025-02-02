import 'package:flutter/material.dart';
import 'package:property_service_web/core/enums/button_type.dart';
import 'package:property_service_web/core/enums/main_screen_type.dart';
import 'package:property_service_web/widgets/crud_button.dart';

import 'main_title.dart';

class SubLayout extends StatelessWidget {
  final MainScreenType mainScreenType;
  final List<ButtonType>? buttonTypeList;
  final VoidCallback? onSavePressed;
  final VoidCallback? onSubmitPressed;
  final VoidCallback? onUpdatePressed;
  final VoidCallback? onDeletePressed;

  final Widget child;

  SubLayout({
    super.key,
    required this.mainScreenType,
    required this.child,
    this.buttonTypeList,
    this.onSavePressed,
    this.onSubmitPressed,
    this.onUpdatePressed,
    this.onDeletePressed,
  });

  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        controller: verticalScrollController,
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          controller: horizontalScrollController,
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width - 276,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainTitle(title: mainScreenType.name), // MainScreenType에 따라 제목 동적 변경
                      Row(
                        children: _buildButtons(), // 버튼 리스트를 동적으로 생성
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 버튼 리스트 생성 함수
  List<Widget> _buildButtons() {
    if (buttonTypeList == null || buttonTypeList!.isEmpty) return [];

    List<Widget> buttons = [];
    for (var buttonType in buttonTypeList!) {
      switch (buttonType) {
        case ButtonType.save:
          buttons.add(
            CRUDButton(buttonType: ButtonType.save, onPressed: onSavePressed ?? () {}),
          );
          break;
        case ButtonType.submit:
          buttons.add(
            CRUDButton(buttonType: ButtonType.submit, onPressed: onSubmitPressed ?? () {}),
          );
          break;
        case ButtonType.update:
          buttons.add(
            CRUDButton(buttonType: ButtonType.update, onPressed: onUpdatePressed ?? () {}),
          );
          break;
        case ButtonType.delete:
          buttons.add(
            CRUDButton(buttonType: ButtonType.delete, onPressed: onDeletePressed ?? () {}),
          );
          break;
      }
    }

    // 버튼 간 간격 추가
    return buttons
        .expand((button) => [button, const SizedBox(width: 8)])
        .toList()
      ..removeLast(); // 마지막 간격 제거
  }
}
