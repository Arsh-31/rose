// calendar_picker.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CalendarPicker({super.key, required this.onDateSelected});

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFBF5E7),
          borderRadius: BorderRadius.circular(16),
          border: const Border(
            top: BorderSide(color: Colors.black, width: 2),
            left: BorderSide(color: Colors.black, width: 2),
            right: BorderSide(color: Colors.black, width: 6),
            bottom: BorderSide(color: Colors.black, width: 6),
          ),
        ),
        child: TableCalendar(
          firstDay: DateTime(2019),
          lastDay: DateTime(2050),
          focusedDay: focusedDay,
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          onDaySelected: (day, focus) {
            setState(() {
              selectedDay = day;
              focusedDay = focus;
            });
            widget.onDateSelected(day);
          },
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Color(0xFFF7CBB1),
              shape: BoxShape.circle,
            ),
            todayTextStyle: TextStyle(
              color: Colors.black, // Change current day text color to black
            ),
            selectedDecoration: BoxDecoration(
              color: Color(0xFFFBF5E7),
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                BorderSide(color: Colors.black, width: 2),
              ),
            ),
            defaultTextStyle: TextStyle(color: Colors.black87),
            weekendTextStyle: TextStyle(color: Colors.black87),
          ),
          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ),
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
