import 'package:flutter/material.dart';
import 'package:property_service_web/models/maintenance_form.dart';
import 'package:property_service_web/widgets/custom_text_field.dart';

class MaintenanceCostForm extends StatefulWidget {
  final MaintenanceFormModel maintenanceFormModel;
  const MaintenanceCostForm({super.key, required this.maintenanceFormModel});

  @override
  State<MaintenanceCostForm> createState() => _MaintenanceCostFormState();
}

class _MaintenanceCostFormState extends State<MaintenanceCostForm> {
  final TextEditingController maintenanceFeeController = TextEditingController();
  final TextEditingController otherController = TextEditingController();

  bool isOthers = false;

  @override
  void initState() {
    maintenanceFeeController.addListener(_updateMaintenanceFee);
    otherController.addListener(_updateOthers);
    super.initState();
  }

  @override
  void dispose() {
    maintenanceFeeController.removeListener(_updateMaintenanceFee);
    otherController.removeListener(_updateOthers);
    super.dispose();
  }

  void _updateMaintenanceFee() {
    setState(() {
      widget.maintenanceFormModel.maintenanceFee =
          int.tryParse(maintenanceFeeController.text) ?? 0;
    });
  }

  void _updateOthers() {
    setState(() {
      widget.maintenanceFormModel.others = otherController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    "관리비",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 300,
              child: CustomTextField(
                label: "관리비",
                controller: maintenanceFeeController,
              ),
            ),
          ],
        ),
        SizedBox(width: 24),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _checkboxWithLabel(
                  "수도",
                  widget.maintenanceFormModel.isWaterSelected,
                      (newValue) {
                    setState(() {
                      widget.maintenanceFormModel.isWaterSelected = newValue!;
                    });
                  },
                ),
                _checkboxWithLabel(
                  "전기",
                  widget.maintenanceFormModel.isElectricitySelected,
                      (newValue) {
                    setState(() {
                      widget.maintenanceFormModel.isElectricitySelected =
                      newValue!;
                    });
                  },
                ),
                _checkboxWithLabel(
                  "인터넷",
                  widget.maintenanceFormModel.isInternetSelected,
                      (newValue) {
                    setState(() {
                      widget.maintenanceFormModel.isInternetSelected =
                      newValue!;
                    });
                  },
                ),
                _checkboxWithLabel(
                  "난방",
                  widget.maintenanceFormModel.isHeatingSelected,
                      (newValue) {
                    setState(() {
                      widget.maintenanceFormModel.isHeatingSelected = newValue!;
                    });
                  },
                ),
              ],
            ),
            // SizedBox(
            //   height: 100,
            //   child: Row(
            //     children: [
            //       _checkboxWithLabel(
            //         "기타",
            //         isOthers,
            //             (newValue) {
            //           setState(() {
            //             isOthers = newValue!;
            //             if (!isOthers) {
            //               otherController.clear();
            //               widget.maintenanceFormModel.others = '';
            //             }
            //           });
            //         },
            //       ),
            //       if (isOthers)
            //         SizedBox(
            //           width: 240,
            //           child: CustomTextField(
            //             label: "기타 관리비 항목",
            //             controller: otherController,
            //           ),
            //         ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  Widget _checkboxWithLabel(
      String label,
      bool value,
      ValueChanged<bool?>? onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // 수직 중앙 정렬
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.grey[800],
            hoverColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            visualDensity: VisualDensity.compact, // 여백 조정
          ),
          SizedBox(height: 24), // Checkbox와 Text 사이의 크기를 조정
          Text(
            label,
            style: TextStyle(fontSize: 14), // 텍스트 크기 조정
          ),
        ],
      ),
    );
  }

}
