import 'package:flutter/material.dart';
import 'package:property_service_web/core/enums/main_screen_type.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(MainScreenType.Calendar.name),
      ),
    );
  }
}
