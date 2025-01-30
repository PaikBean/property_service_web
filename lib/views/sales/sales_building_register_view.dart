import 'package:flutter/material.dart';

class SalesBuildingRegisterView extends StatefulWidget {
  const SalesBuildingRegisterView({super.key});

  @override
  State<SalesBuildingRegisterView> createState() => _SalesBuildingRegisterViewState();
}

class _SalesBuildingRegisterViewState extends State<SalesBuildingRegisterView> {
  TextEditingController buildingName = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController parkingSpacesController = TextEditingController();
  TextEditingController floorsController = TextEditingController();
  TextEditingController gatePasswordController = TextEditingController();
  TextEditingController directionController = TextEditingController();
  TextEditingController constructionYearController = TextEditingController();
  TextEditingController remark = TextEditingController();

  String? buildingUsage;
  String? elevatorAvailable;
  String? violationStatus;
  String? mainPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "| 건물 등록",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
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
                  width: 800,
                  child: _buildTextField("건물 이름", buildingName),
              ),
              const SizedBox(height: 24),
              SizedBox(
                  width: 800,
                  child: _buildTextField("주소", addressController, readOnly: true),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 800,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: _buildTextField("주차 대수", parkingSpacesController, keyboardType: TextInputType.number),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      flex: 1,
                      child: _buildTextField("층 수", floorsController, keyboardType: TextInputType.number),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      flex: 1,
                      child: _buildTextField("주 출입문 방향", directionController),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      flex:1,
                      child: _buildTextField("준공 년도", constructionYearController, keyboardType: TextInputType.number),    // todo 캘린더 위젯 사용
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 800,
                  child: Row(
                    children: [
                      Flexible(
                          flex:1,
                          child: _buildRadioGroup("건물 용도", ["주거용", "상업용"], buildingUsage, (value) => setState(() => buildingUsage = value)),
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          children: [
                            _buildRadioGroup("승강기 유무", ["있음", "없음"], elevatorAvailable, (value) => setState(() => elevatorAvailable = value)),
                            if(elevatorAvailable == "있음")
                              Container(
                                width: 160,
                                height: 64,
                                alignment: Alignment.bottomCenter,
                                child: _buildTextField("승강기 대수", TextEditingController(), keyboardType: TextInputType.number),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 800,
                child: Row(
                  children: [
                    Flexible(
                      flex:1,
                      child: _buildRadioGroup("위반 건축물 여부", ["있음", "없음"], violationStatus, (value) => setState(() => violationStatus = value)),
                    ),
                    Flexible(
                      flex:1,
                      child: Row(
                        children: [
                          _buildRadioGroup("공통 현관문 비밀번호", ["있음", "없음"], mainPassword, (value) => setState(() => mainPassword = value)),
                          if(mainPassword == "있음")
                            Container(
                              width: 160,
                              height: 64,
                              alignment: Alignment.bottomCenter,
                              child: _buildTextField("공통 현관문 비밀번호", TextEditingController(), keyboardType: TextInputType.number),
                            ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 800,
                child: _buildTextField("특이사항", remark, maxLine: 4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool readOnly = false, bool obscureText = false, TextInputType? keyboardType, int? maxLine}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: label,
          border: OutlineInputBorder(),
        ),
        textAlignVertical: TextAlignVertical.top, // 텍스트를 위쪽 정렬
        maxLines: maxLine,
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
          width: 150,
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
    // 폼 제출 로직
    print("폼 제출");
  }
}
