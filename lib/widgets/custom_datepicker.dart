import 'package:flutter/material.dart';
import 'package:property_service_web/core/constants/app_colors.dart';
import 'package:property_service_web/core/enums/datepicker_type.dart';
import 'package:property_service_web/core/utils/datepicker_utils.dart';
import 'package:property_service_web/core/utils/format_utils.dart';

class CustomDatePicker extends StatefulWidget {
  final DatePickerType datePickerType;
  final String label;
  DateTime? selectedDateTime;

  CustomDatePicker({
    super.key,
    required this.datePickerType,
    required this.label,
    required this.selectedDateTime,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  TextEditingController selectedDateText = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleDate() async {
    DateTime? selected = await DatePickerUtils.selectDate(
      context,
      widget.selectedDateTime,
    );
    if (selected != null) {
      setState(() {
        widget.selectedDateTime = selected;
        selectedDateText.text = FormatUtils.formatToYYYYMMDD(selected);
      });
    }
  }

  Future<void> _handleYearMonth() async {
    DateTime? selected = await DatePickerUtils.selectYearMonth(
      context,
      widget.selectedDateTime,
    );
    if (selected != null) {
      setState(() {
        widget.selectedDateTime = selected;
        selectedDateText.text = "${selected.year} ${selected.month}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: selectedDateText,
        readOnly: true,
        onTap: _handleYearMonth,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: widget.label,
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.color5, // 초록색 강조
              width: 2.0,
            ),
          ),
          labelStyle: TextStyle(
            color: AppColors.color5, // 라벨 텍스트 색상
          ),
          suffixIcon: Icon(
            Icons.calendar_month,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
