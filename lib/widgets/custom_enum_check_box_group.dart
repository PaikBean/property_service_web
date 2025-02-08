import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class CustomEnumCheckboxGroup<T> extends StatefulWidget {
  final String title;
  final List<T> options; // Enum 또는 String을 지원
  final List<T>? selectedValues;
  final T? otherInput;
  final String? otherLabel;
  final double otherInputBoxWidth;
  final TextEditingController? otherInputTextController;
  final Function(List<T>) onChanged;

  const CustomEnumCheckboxGroup({
    super.key,
    required this.title,
    required this.options,
    this.selectedValues,
    required this.onChanged,
    this.otherInput,
    this.otherLabel,
    this.otherInputBoxWidth = 200,
    this.otherInputTextController,
  });

  @override
  _CustomEnumCheckboxGroupState<T> createState() => _CustomEnumCheckboxGroupState<T>();
}

class _CustomEnumCheckboxGroupState<T> extends State<CustomEnumCheckboxGroup<T>> {
  List<T> _selectedValues = [];

  @override
  void initState() {
    // TODO: implement initState
    if(widget.selectedValues != null){
      _selectedValues = List.from(widget.selectedValues!);
    }
    super.initState();
  }

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
                    if(option is Enum && (option as dynamic).label == "") {
                      return SizedBox.shrink();
                    }
                    return Row(
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
          ),
          if (_selectedValues.contains(widget.otherInput))
            SizedBox(
              width: widget.otherInputBoxWidth,
              child: CustomTextField(
                label: widget.otherLabel!,
                controller: widget.otherInputTextController!,
              ),
            ),
        ],
      ),
    );
  }
}
