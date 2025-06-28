import 'package:app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _nameController.text = userProvider.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final selectedDate = userProvider.selectedDate;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF5E7),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF7CBB1),
            borderRadius: BorderRadius.circular(16),
            border: const Border(
              top: BorderSide(color: Colors.black, width: 2),
              left: BorderSide(color: Colors.black, width: 2),
              right: BorderSide(color: Colors.black, width: 7),
              bottom: BorderSide(color: Colors.black, width: 7),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Update Your Info",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFFBF5E7),
                  labelText: 'Your name',
                  labelStyle: const TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate != null
                        ? "Birthday: ${DateFormat('MMM dd, yyyy').format(selectedDate)}"
                        : "No birthday set",
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2050),
                      );
                      if (picked != null) {
                        userProvider.setSelectedDate(picked);
                      }
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    child: const Text("Change"),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              InkWell(
                onTap: () {
                  userProvider.setName(_nameController.text.trim());

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Settings updated."),
                      backgroundColor: Colors.black87,
                    ),
                  );
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
                        "Save",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.save, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
