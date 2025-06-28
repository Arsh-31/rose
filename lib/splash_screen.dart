import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app/name_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NamePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5E7),
      body: Center(
        child: Container(
          width: 250,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: const Color(0xFFF7CBB1),
            borderRadius: BorderRadius.circular(14),
            border: Border(
              top: BorderSide(color: Colors.black, width: 2),
              left: BorderSide(color: Colors.black, width: 2),
              right: BorderSide(color: Colors.black, width: 7),
              bottom: BorderSide(color: Colors.black, width: 7),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(4, 4),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "For our dear",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Divider(thickness: 2, color: Colors.black),
              SizedBox(height: 16),
              Text(
                "Rosè",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
