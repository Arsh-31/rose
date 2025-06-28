import 'package:app/home_page.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/utils/calender_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DatePage extends StatefulWidget {
  const DatePage({super.key});

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final name = userProvider.name;
    final selectedDate = userProvider.selectedDate;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF5E7),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: const Color(0xFFF7CBB1),
              borderRadius: BorderRadius.circular(16),
              border: const Border(
                top: BorderSide(color: Colors.black, width: 2),
                left: BorderSide(color: Colors.black, width: 2),
                right: BorderSide(color: Colors.black, width: 6),
                bottom: BorderSide(color: Colors.black, width: 6),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(4, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Hi, $name!",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  selectedDate == null
                      ? "You haven't picked a date yet."
                      : "Selected Date: ${DateFormat('MMMM dd, yyyy').format(selectedDate)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        selectedDate == null ? Colors.black54 : Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),

                // Pick Date Button
                InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: CalendarPicker(
                            onDateSelected: (pickedDate) {
                              userProvider.setSelectedDate(pickedDate);
                              Navigator.pop(context); // close dialog
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF5E7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today, color: Colors.black),
                        SizedBox(width: 8),
                        Text(
                          'Pick a Date',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Continue Button
                InkWell(
                  onTap: () {
                    if (selectedDate != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a date."),
                          backgroundColor: Colors.black87,
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF5E7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Continue",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
