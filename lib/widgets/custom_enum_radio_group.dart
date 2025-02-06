import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class CustomEnumRadioGroup<T> extends StatelessWidget {
  final String title;
  final List<T> options; // Enum이나 String 모두 지원
  final T? groupValue;
  final void Function(T?) onChanged;
  final T? otherInput;
  final String? otherLabel;
  final TextEditingController? otherTextController;
  final double otherInputBoxWidth;

  const CustomEnumRadioGroup({
    super.key,
    required this.title,
    required this.options,
    required this.groupValue,
    required this.onChanged,
    this.otherInput,
    this.otherLabel,
    this.otherTextController,
    this.otherInputBoxWidth = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: options.map((option) {
                    if(option is Enum && (option as dynamic).label == "") {
                      return SizedBox.shrink();
                    }
                    return Row(
                      children: [
                        Radio<T>(
                          value: option,
                          groupValue: groupValue,
                          onChanged: onChanged,
                          activeColor: Colors.grey[800],
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                        ),
                        Text(
                          option is Enum
                              ? (option as dynamic).label // Enum의 label 속성을 가져옴
                              : option.toString(),
                        ),
                        const SizedBox(width: 16),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
            if (otherInput != null && otherInput == groupValue)
              SizedBox(
                width: otherInputBoxWidth,
                child: CustomTextField(
                  label: otherLabel!,
                  controller: otherTextController!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
