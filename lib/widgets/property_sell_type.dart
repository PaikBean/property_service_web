import 'package:flutter/material.dart';
import 'package:property_service_web/widgets/custom_text_field.dart';

import 'custom_radio_group.dart';

class PropertySellType extends StatefulWidget {
  final TextEditingController monthlyDepositAmountController;
  final TextEditingController monthlyAmountController;
  final TextEditingController jeonseAmountController;
  final TextEditingController saleAmountController;
  final TextEditingController shortTermDepositAmountController;
  final TextEditingController shortTermMonthlyAmountController;

  const PropertySellType({
    super.key,
    required this.monthlyDepositAmountController,
    required this.monthlyAmountController,
    required this.jeonseAmountController,
    required this.saleAmountController,
    required this.shortTermDepositAmountController,
    required this.shortTermMonthlyAmountController,
  });

  @override
  State<PropertySellType> createState() => _PropertySellTypeState();
}

class _PropertySellTypeState extends State<PropertySellType> {
  String? selectedSellType;

  @override
  void initState() {
    super.initState();

    // TextEditingController의 리스너 추가
    widget.monthlyDepositAmountController.addListener(_changeInput);
    widget.monthlyAmountController.addListener(_changeInput);
    widget.jeonseAmountController.addListener(_changeInput);
    widget.saleAmountController.addListener(_changeInput);
    widget.shortTermDepositAmountController.addListener(_changeInput);
    widget.shortTermMonthlyAmountController.addListener(_changeInput);
  }

  @override
  void dispose() {
    // 리스너 제거
    widget.monthlyDepositAmountController.removeListener(_changeInput);
    widget.monthlyAmountController.removeListener(_changeInput);
    widget.jeonseAmountController.removeListener(_changeInput);
    widget.saleAmountController.removeListener(_changeInput);
    widget.shortTermDepositAmountController.removeListener(_changeInput);
    widget.shortTermMonthlyAmountController.removeListener(_changeInput);
    super.dispose();
  }

  void _changeInput() {
    setState(() {}); // 상태 변경으로 UI 갱신
    print("왜 입력이 안먹혀");
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "판매 유형 및 가격",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              SizedBox(height: 30),
              if(widget.monthlyDepositAmountController.text.isNotEmpty && widget.monthlyAmountController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 4, bottom: 4),
                  child: Row(
                    children: [
                      Text(
                        "월세",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${widget.monthlyDepositAmountController.text}/${widget.monthlyAmountController.text} 원",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              if(widget.jeonseAmountController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 4, bottom: 4),
                  child: Row(
                    children: [
                      Text(
                        "전세",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${widget.jeonseAmountController.text} 원",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              if(widget.saleAmountController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 4, bottom: 4),
                  child: Row(
                    children: [
                      Text(
                        "매매",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${widget.saleAmountController.text} 원",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              if(widget.shortTermDepositAmountController.text.isNotEmpty && widget.shortTermMonthlyAmountController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 4, bottom: 4),
                  child: Row(
                    children: [
                      Text(
                        "단기",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${widget.shortTermDepositAmountController.text}/${widget.shortTermMonthlyAmountController.text} 원",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: 40),
        SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRadioGroup(
                title: "매물 판매 형태",
                options: ["월세", "전세", "매매", "단기"],
                groupValue: selectedSellType,
                onChanged: (value) {
                  setState(() {
                    selectedSellType = value;
                  });
                },
              ),
              if (selectedSellType == "월세")
                SizedBox(
                  width: 400,
                  child: Row(
                    children: [
                      Flexible(child: CustomTextField(label: "보증금", controller: widget.monthlyDepositAmountController)),
                      const SizedBox(height: 8),
                      Flexible(child: CustomTextField(label: "월세", controller: widget.monthlyAmountController)),
                    ],
                  ),
                ),
              if (selectedSellType == "전세")
                SizedBox(
                  width: 200,
                  child: CustomTextField(label: "전세금", controller: widget.jeonseAmountController),
                ),
              if (selectedSellType == "매매")
                SizedBox(
                  width: 200,
                  child: CustomTextField(label: "매매금", controller: widget.saleAmountController),
                ),
              if(selectedSellType == "단기")
                SizedBox(
                  width: 400,
                  child: Row(
                    children: [
                      Flexible(child: CustomTextField(label: "보증금", controller: widget.shortTermDepositAmountController)),
                      const SizedBox(height: 8),
                      Flexible(child: CustomTextField(label: "월세", controller: widget.shortTermMonthlyAmountController)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}