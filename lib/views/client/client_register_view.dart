import 'package:flutter/material.dart';

import '../../core/enums/button_type.dart';
import '../../core/enums/main_screen_type.dart';
import '../../widgets/custom_radio_group.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/sub_layout.dart';

class ClientRegisterView extends StatefulWidget {
  const ClientRegisterView({super.key});

  @override
  State<ClientRegisterView> createState() => _ClientRegisterViewState();
}

class _ClientRegisterViewState extends State<ClientRegisterView> {
  String? clientGender;
  String? clientSource;


  @override
  Widget build(BuildContext context) {
    return SubLayout(
      mainScreenType: MainScreenType.ClientRegister,
      buttonTypeList: [ButtonType.submit],
      onSubmitPressed: (){},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: CustomTextField(label: "고객 성함", controller: TextEditingController()),
          ),
          SizedBox(
            width: 800,
            child: CustomTextField(label: "고객 전화번호", controller: TextEditingController()),
          ),
          SizedBox(
            width: 800,
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: CustomRadioGroup(
                    title: "고객 성별",
                    options: ["남성", "여성"],
                    groupValue: clientGender,
                    onChanged: (value) => setState(() => clientGender = value),
                  ),
                ),
                CustomRadioGroup(
                  title: "유입 경로",
                  options: ["직방", "다방", "피터팬", "기타"],
                  groupValue: clientSource,
                  onChanged: (value) => setState(() => clientSource = value),
                  otherInput: "기타",
                  otherLabel: "유입 경로",
                  otherInputTextController: TextEditingController(),
                  otherInputBoxWidth: 240,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 800,
            child: CustomTextField(
              label: "특이사항",
              controller: TextEditingController(),
              maxLines: 4,
            ),
          ),
        ],
      ),
    );
  }
}
