import 'package:flutter/material.dart';
import 'package:property_service_web/core/constants/app_colors.dart';
import 'package:property_service_web/core/enums/main_screen_type.dart';
import 'package:property_service_web/widgets/sub_layout.dart';
import 'package:property_service_web/widgets/sub_title.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class CalendarScheduleSummaryModel {
  final int id;
  final String scheduleDateTime;
  final String scheduleManage;
  final String scheduleClientName;
  final String scheduleType;

  CalendarScheduleSummaryModel({
    required this.id,
    required this.scheduleDateTime,
    required this.scheduleManage,
    required this.scheduleClientName,
    required this.scheduleType,
  });
}

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<CalendarScheduleSummaryModel> schedules1 = [
    CalendarScheduleSummaryModel(id: 1, scheduleDateTime: "2", scheduleManage: "담당 매니저", scheduleClientName: "고객1", scheduleType: "상담"),
  ];

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
        scheduleDateTime: DateTime(2025, 2, randomDay, randomHour, randomMinute).toIso8601String(),
        scheduleManage: '관리자${index + 1}',
        scheduleClientName: '고객${index + 1}',
        scheduleType: ['상담', '계약', '입주', '입주완료'][random.nextInt(4)],
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
    return SubLayout(
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
            children: [
              Container(
                width: 680,
                color: Colors.grey,
                child: SubTitle(title: "${_selectedDay.year.toString()}년 ${_selectedDay.month}월 ${_selectedDay.day}일 일정"),
              ),
              SizedBox(

              ),
            ],
          ),
        ],
      ),
    );
  }
}
