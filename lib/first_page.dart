import 'package:app/providers/user_provider.dart';
import 'package:app/utils/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final name = userProvider.name;
    final selectedDate = userProvider.selectedDate;

    final selected =
        selectedDate != null
            ? DateTime(selectedDate.year, selectedDate.month, selectedDate.day)
            : null;

    int? daysLeft;

    if (selected != null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final nextBirthday = DateTime(today.year, selected.month, selected.day);

      if (nextBirthday.isBefore(today)) {
        final nextYearBirthday = DateTime(
          today.year + 1,
          selected.month,
          selected.day,
        );
        daysLeft = nextYearBirthday.difference(today).inDays;
      } else {
        daysLeft = nextBirthday.difference(today).inDays;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFBF5E7),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFBF5E7),
                border: Border(
                  top: BorderSide(color: Colors.black, width: 2),
                  left: BorderSide(color: Colors.black, width: 2),
                  right: BorderSide(color: Colors.black, width: 6),
                  bottom: BorderSide(color: Colors.black, width: 6),
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 1, 1),
                lastDay: DateTime.utc(2050, 12, 31),
                focusedDay: DateTime.now(), // Show current month
                selectedDayPredicate:
                    (day) => isSameDay(
                      day,
                      selected, // The birthday you selected earlier
                    ),
                onDaySelected: (_, __) {}, // Do nothing on tap
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xFFF7CBB1),
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  selectedTextStyle: const TextStyle(color: Colors.black),
                  todayDecoration: const BoxDecoration(
                    color: Color(0xFFFBF5E7), // light highlight for today
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: Colors.black, width: 1.5),
                    ),
                  ),
                  todayTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  weekendTextStyle: const TextStyle(color: Colors.black54),
                  defaultTextStyle: const TextStyle(color: Colors.black87),
                ),

                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            if (selectedDate != null) const SizedBox(height: 10),
            Text(
              "Hello, $name!",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            if (daysLeft != null)
              Text(
                daysLeft == 0
                    ? "It's your birthday today!!"
                    : "$daysLeft days left until your birthday",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            // ElevatedButton(
            //   onPressed: () {
            //     NotificationService().showNotification(
            //       id: 0,
            //       title: "Title",
            //       body: "Body",
            //     );
            //   },
            //   child: const Text("Send Notif"),
            // ),
          ],
        ),
      ),
    );
  }
}
