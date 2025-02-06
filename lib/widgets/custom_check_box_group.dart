import 'package:flutter/material.dart';
import 'package:property_service_web/widgets/custom_text_field.dart';

class CustomCheckboxGroup extends StatefulWidget {
  final String title;
  final List<String> options;
  final String? otherInput;
  final String? otherLabel;
  final double otherInputBoxWidth;
  final TextEditingController? otherInputTextController;
  final Function(List<String>) onChanged;

  const CustomCheckboxGroup({
    super.key,
    required this.title,
    required this.options,
    required this.onChanged,
    this.otherInput,
    this.otherLabel,
    this.otherInputBoxWidth = 200,
    this.otherInputTextController,
  });

  @override
  _CustomCheckboxGroupState createState() => _CustomCheckboxGroupState();
}

class _CustomCheckboxGroupState extends State<CustomCheckboxGroup> {
  List<String> _selectedValues = [];

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
                    widget.title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: widget.options.map((option) {
                    return Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _selectedValues.contains(option),
                              onChanged: (bool? checked) {
                                setState(() {
                                  if (checked == true) {
                                    _selectedValues.add(option);
                                  } else {
                                    _selectedValues.remove(option);
                                  }
                                  widget.onChanged(_selectedValues);
                                });
                              },
                              activeColor: Colors.grey[800],
                              overlayColor: WidgetStateProperty.all(Colors.transparent),
                            ),
                            Text(option),
                            SizedBox(width: 16),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          if (_selectedValues.contains(widget.otherInput))
            SizedBox(
              width: widget.otherInputBoxWidth,
              child: CustomTextField(label: widget.otherLabel!, controller: widget.otherInputTextController!),
            ),
        ],
      ),
    );
  }
}
