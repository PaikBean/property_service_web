import 'package:flutter/material.dart';
import 'package:property_service_web/widgets/custom_text_field.dart';

class CustomRadioGroup extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? groupValue;
  final void Function(String?) onChanged;
  final String? otherInput;
  final String? otherLabel;
  final TextEditingController? otherInputTextController;
  final double otherInputBoxWidth;

  const CustomRadioGroup({
    super.key,
    required this.title,
    required this.options,
    required this.groupValue,
    required this.onChanged,
    this.otherInput,
    this.otherLabel,
    this.otherInputTextController,
    this.otherInputBoxWidth = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: options.map((option) {
                    return Row(
                      children: [
                        Radio<String>(
                          value: option,
                          groupValue: groupValue,
                          onChanged: onChanged,
                          activeColor: Colors.black,
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                        ),
                        Text(option),
                        SizedBox(width: 16),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          if(otherInput != null && otherInput == groupValue)
            SizedBox(
                width: otherInputBoxWidth,
                child: CustomTextField(label: otherLabel!, controller: otherInputTextController!),
            ),
        ],
      ),
    );
  }
}
