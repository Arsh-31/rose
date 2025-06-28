import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _name = '';
  DateTime? _selectedDate;

  String get name => _name;
  DateTime? get selectedDate => _selectedDate;

  void setName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
