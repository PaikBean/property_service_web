import 'package:flutter/material.dart';
import 'package:kpostal_web/model/kakao_address.dart';
import '../core/constants/app_colors.dart';
import '../core/utils/dialog_utils.dart';

class CustomAddressField extends StatefulWidget {
  final String label;
  String? zipCode;
  String? address;
  final Function(String?, String?)? onChanged; // 추가
  CustomAddressField({super.key, required this.label, required this.zipCode, required this.address, this.onChanged});

  @override
  State<CustomAddressField> createState() => _CustomAddressFieldState();
}

class _CustomAddressFieldState extends State<CustomAddressField> {
  late TextEditingController controller;

  @override
  void didUpdateWidget(covariant CustomAddressField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.zipCode != widget.zipCode || oldWidget.address != widget.address) {
      controller.text = _buildAddressText(widget.zipCode, widget.address);
    }
  }

  String _buildAddressText(String? zipCode, String? address) {
    if ((zipCode == null || zipCode.isEmpty) && (address == null || address.isEmpty)) {
      return ""; // zipCode와 address가 모두 비어있으면 빈 문자열 반환
    } else if (zipCode != null && zipCode.isNotEmpty) {
      return "($zipCode) ${address ?? ""}";
    } else {
      return address ?? "";
    }
  }


  @override
  void initState() {
    controller = TextEditingController(
      text: widget.zipCode != null
          ? "(${widget.zipCode}) ${widget.address ?? ""}"
          : widget.address ?? "",
    );
    super.initState();
  }

  void _selectAddress() async {
    KakaoAddress? result = await DialogUtils.showAddressSearchDialog(context: context);
    print('onComplete KakaoAddress: $result');
    if (result != null) {
      print('선택된 주소: ${result.address}');
      print('우편번호: ${result.postCode}');
      setState(() {
        widget.zipCode = result.postCode;
        widget.address = result.address;
        controller.text = "(${widget.zipCode}) ${widget.address}";
        widget.onChanged?.call(widget.zipCode, widget.address);
      });
    } else {
      print('주소 선택이 취소되었습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: () => _selectAddress(),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: widget.label,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.color5,
              width: 2.0,
            ),
          ),
          labelStyle: TextStyle(color: AppColors.color5),
          suffixIcon: IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () => _selectAddress(),
          ),
        ),
      ),
    );
  }
}
