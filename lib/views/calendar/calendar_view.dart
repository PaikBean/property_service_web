import 'package:flutter/material.dart';
import 'package:property_service_web/core/constants/app_colors.dart';
import 'package:property_service_web/core/enums/button_type.dart';
import 'package:property_service_web/core/enums/main_screen_type.dart';
import 'package:property_service_web/core/utils/toast_manager.dart';
import 'package:property_service_web/widgets/crud_button.dart';
import 'package:property_service_web/widgets/sub_layout.dart';
import 'package:property_service_web/widgets/sub_title.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import '../../widgets/rotating_house_indicator.dart';

class CalendarScheduleSummaryModel {
  final int id;
  bool scheduleComplete;
  final String scheduleDateTime;
  final String scheduleManage;
  final String scheduleClientName;
  final String scheduleType;
  final String scheduleRemark;

  CalendarScheduleSummaryModel({
    required this.id,
    required this.scheduleComplete,
    required this.scheduleDateTime,
    required this.scheduleManage,
    required this.scheduleClientName,
    required this.scheduleType,
    required this.scheduleRemark
  });
}

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  bool _isLoading = false;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  Future<void> updateScheduleCompletion(
      CalendarScheduleSummaryModel schedule, bool isChecked) async {
    setState(() {
      final updatedSchedule = CalendarScheduleSummaryModel(
        id: schedule.id,
        scheduleComplete: isChecked, // 새 상태 반영
        scheduleDateTime: schedule.scheduleDateTime,
        scheduleManage: schedule.scheduleManage,
        scheduleClientName: schedule.scheduleClientName,
        scheduleType: schedule.scheduleType,
        scheduleRemark: schedule.scheduleRemark,
      );

      final index = schedules.indexOf(schedule);
      schedules[index] = updatedSchedule; // 리스트 업데이트
    });
    ToastManager().showToast(context, "일정이 ${isChecked ? "완료" : "미완료"} 처리되었습니다.");
  }

  // Example schedule data
  List<CalendarScheduleSummaryModel> schedules = List.generate(
    40,
        (index) {
      final random = Random();
      final randomDay = random.nextInt(28) + 1; // February 1-28
      final randomHour = random.nextInt(9) + 9; // 9 AM - 5 PM
      final randomMinute = random.nextInt(60);

      return CalendarScheduleSummaryModel(
        id: index + 1,
        scheduleComplete: false,
        scheduleDateTime: DateTime(2025, 2, randomDay, randomHour, randomMinute).toIso8601String(),
        scheduleManage: '관리자${index + 1}',
        scheduleClientName: '고객${index + 1}',
        scheduleType: ['상담', '계약', '입주'][random.nextInt(3)],
        scheduleRemark: "특이사항입니다.",
      );
    },
  );

  // Load events for a specific day
  List<CalendarScheduleSummaryModel> _getEventsForDay(DateTime day) {
    return schedules.where((schedule) {
      final scheduleDate = DateTime.parse(schedule.scheduleDateTime);
      return scheduleDate.year == day.year &&
          scheduleDate.month == day.month &&
          scheduleDate.day == day.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SubLayout(
          mainScreenType: MainScreenType.Calendar,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 720,
                height: 800,
                child: TableCalendar(
                  locale: "ko_KR",
                  firstDay: DateTime.utc(1900, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: CalendarFormat.month,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  availableGestures: AvailableGestures.none,

                  eventLoader: _getEventsForDay,
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    headerMargin: EdgeInsets.symmetric(vertical: 8),
                  ),

                  daysOfWeekHeight: 16,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    weekendStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(
                      fontSize: 16,  // 날짜 숫자 크기 키우기
                    ),
                    weekendTextStyle: TextStyle(
                      fontSize: 16,  // 주말 날짜 크기 키우기
                    ),
                    outsideTextStyle: TextStyle(
                      fontSize: 16,  // 달력 밖(이전/다음 달) 날짜 크기
                      color: Colors.grey, // 흐린 색상으로 표시
                    ),

                    selectedDecoration: BoxDecoration(
                      color: AppColors.color2,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),

                  rowHeight: 120,

                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        // 이벤트 유형별로 그룹화 및 개수 계산
                        Map<String, int> eventCounts = {
                          '상담': 0,
                          '계약': 0,
                          '입주': 0,
                          '입주완료': 0,
                        };

                        for (var event in events) {
                          final schedule = event as CalendarScheduleSummaryModel;
                          if (eventCounts.containsKey(schedule.scheduleType)) {
                            eventCounts[schedule.scheduleType] =
                                eventCounts[schedule.scheduleType]! + 1;
                          }
                        }

                        // 색상 맵핑
                        Map<String, Color> typeColors = {
                          '상담': Colors.green,
                          '계약': Colors.red.shade500,
                          '입주': Colors.blue,
                          '입주완료': Colors.orange,
                        };

                        // 이벤트에 따라 줄들을 표시
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 56),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: eventCounts.entries.map((entry) {
                                if (entry.value > 0) {
                                  return Container(
                                    width: 56,
                                    height: 6,
                                    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                    color: typeColors[entry.key],
                                  );
                                }
                                return SizedBox.shrink(); // 이벤트가 없는 유형은 표시하지 않음
                              }).toList(),
                            ),
                          ],
                        );
                      }
                      return null;
                    },
                  ),

                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildLegendItem(Colors.green, "상담"),
                        SizedBox(width: 16),
                        _buildLegendItem(Colors.red.shade500, "계약"),
                        SizedBox(width: 16),
                        _buildLegendItem(Colors.blue, "입주"),
                        SizedBox(width: 16),
                        // _buildLegendItem(Colors.orange, "입주완료"),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 680,
                    child: SubTitle(title: "${_selectedDay.year.toString()}년 ${_selectedDay.month}월 ${_selectedDay.day}일 일정"),
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: 680,
                    height: 640,
                    child: ListView.builder(
                      itemCount: _getEventsForDay(_selectedDay).length,
                      itemBuilder: (context, index) {
                        return _buildClientItem(_getEventsForDay(_selectedDay)[index]);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black.withAlpha(1), // 반투명 배경
              ),
              child: Center(
                child: RotatingHouseIndicator(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildClientItem(CalendarScheduleSummaryModel schedule) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white),
      child: Row(
        children: [
          Checkbox(
            value: schedule.scheduleComplete,
            onChanged: (isChecked) {
              if (isChecked != null) {
                updateScheduleCompletion(schedule, isChecked);
              }
            },
            activeColor: Colors.grey[800],
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('HH 시 mm 분').format(DateTime.parse(schedule.scheduleDateTime)), // ✅ 날짜 변환 적용
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 16,),
                  Text(
                    schedule.scheduleManage,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "    /    ",
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    schedule.scheduleClientName,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 16,),
                  Text(
                    schedule.scheduleType,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: getScheduleColor(schedule.scheduleType)
                    ),
                  ),
                  SizedBox(width: 16,),
                  Text(
                    schedule.scheduleRemark,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }

  Color getScheduleColor(String scheduleType) {
    switch (scheduleType) {
      case "상담":
        return Colors.green;
      case "계약":
        return Colors.red.shade500;
      case "입주":
        return Colors.blue;
      case "입주완료":
        return Colors.orange;
      default:
        return Colors.grey; // ✅ 기본값 추가
    }
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
