import 'package:app/first_page.dart';
import 'package:app/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

  void _navigatorBottom(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  final List _pages = const [FirstPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5E7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF5E7),
        elevation: 0,
        title: const Text(
          "Rosè",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 1.2,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(height: 2, thickness: 2, color: Colors.black),
        ),
        centerTitle: true,
      ),

      body: _pages[_selectedPage],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFBF5E7),
          border: Border(top: BorderSide(color: Colors.black, width: 2)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ), // ⬅️ space between border & icons
          child: BottomNavigationBar(
            currentIndex: _selectedPage,
            onTap: _navigatorBottom,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black54,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
