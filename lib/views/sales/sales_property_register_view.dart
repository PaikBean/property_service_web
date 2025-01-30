import 'package:flutter/material.dart';

class SalesPropertyRegisterView extends StatefulWidget {
  const SalesPropertyRegisterView({super.key});

  @override
  State<SalesPropertyRegisterView> createState() =>
      _SalesPropertyRegisterViewState();
}

class _SalesPropertyRegisterViewState
    extends State<SalesPropertyRegisterView> {
  // Controllers for landlord fields
  final TextEditingController landlordNameController = TextEditingController();
  final TextEditingController landlordPhoneController = TextEditingController();
  final TextEditingController landlordRelationController =
  TextEditingController();

  String? landlordGender;

  // Controllers for property fields
  final TextEditingController unitNumberController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController totalFloorsController = TextEditingController();
  final TextEditingController roomsController = TextEditingController();
  final TextEditingController bathroomsController = TextEditingController();
  final TextEditingController directionController = TextEditingController();
  final TextEditingController approvalDateController = TextEditingController();
  final TextEditingController heatingTypeController = TextEditingController();
  final TextEditingController managementFeeController =
  TextEditingController();
  final TextEditingController monthlyRentController = TextEditingController();
  final TextEditingController depositController = TextEditingController();
  final TextEditingController moveInDateController = TextEditingController();

  String? propertyType;
  String? parkingAvailable;
  String? fullOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "| 임대인 정보",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    child: Text("저장"),
                  )
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 400,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                        child: _buildTextField("성명", landlordNameController),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      flex: 2,
                      child: _buildTextField("전화번호", landlordPhoneController,
                          keyboardType: TextInputType.phone),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Row(
                children: [
                  _buildRadioGroup("관계", ["사장", "사모", "기타"], landlordGender, (value) => setState(() => landlordGender = value)),
                  if(landlordGender == "기타")
                    Container(
                      width: 160,
                      height: 64,
                      alignment: Alignment.bottomCenter,
                      child: _buildTextField("관계", TextEditingController(), keyboardType: TextInputType.number),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                "| 매물 정보",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(width: 800, child: _buildTextField("호 수", unitNumberController)),
              SizedBox(
                width:
                800,
                child: Row(
                  children: [
                    Flexible(
                      child: _buildTextField("전용 면적", areaController,
                          keyboardType: TextInputType.number),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: _buildTextField("공급 면적", areaController,
                          keyboardType: TextInputType.number),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 800,
                child: _buildRadioGroup(
                  "매물 형태",
                  ["원룸", "투룸"],
                  propertyType,
                      (value) => setState(() => propertyType = value),
                ),
              ),
              SizedBox(
                width: 800,
                child: Row(
                  children: [
                    Flexible(
                      child: _buildTextField(
                          "해당 층", floorController,
                          keyboardType: TextInputType.number),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: _buildTextField(
                          "전체 층", totalFloorsController,
                          keyboardType: TextInputType.number),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 800,
                child: Row(
                  children: [
                    Flexible(
                      child: _buildTextField("방 개수", roomsController,
                          keyboardType: TextInputType.number),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: _buildTextField("욕실 개수", bathroomsController,
                          keyboardType: TextInputType.number),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: 800, child: _buildTextField("주 실 기준 방향", directionController)),
              SizedBox(
                width: 800,
                child: _buildRadioGroup(
                  "주차 가능 여부",
                  ["가능", "불가능"],
                  parkingAvailable,
                      (value) => setState(() => parkingAvailable = value),
                ),
              ),
              SizedBox(
                  width: 400, child: _buildTextField("사용 승인일", approvalDateController)),    //todo 캘린더 위젯 사용
              SizedBox(width: 800,
                child: _buildRadioGroup(
                  "옵션",
                  ["풀옵션", "일부 옵션"],
                  fullOption,
                      (value) => setState(() => fullOption = value),
                ),
              ),
              SizedBox(width: 800,
                child: _buildRadioGroup(
                  "난방 방식",
                  ["중앙", "개별"],
                  fullOption,
                      (value) => setState(() => fullOption = value),
                ),
              ),
              SizedBox(width: 800,
                child: _buildTextField("관리비", managementFeeController,
                    keyboardType: TextInputType.number),
              ),
              SizedBox(width: 800,
                child: _buildTextField("월세", monthlyRentController,
                    keyboardType: TextInputType.number),
              ),
              SizedBox(width: 800,
                child: _buildTextField("보증금", depositController,
                    keyboardType: TextInputType.number),
              ),
              SizedBox(width: 400, child: _buildTextField("입주 가능일", moveInDateController)),   // todo 캘린더 위젯 사용
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType? keyboardType, int? maxLines}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildRadioGroup(String title, List<String> options, String? groupValue, void Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        SizedBox(
          width: 300,
          child: Row(
            children: options.map((option) {
              return Expanded(
                child: Row(
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: groupValue,
                      onChanged: onChanged,
                    ),
                    Text(option),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    // Handle form submission
    print("폼 제출 완료");
  }
}
