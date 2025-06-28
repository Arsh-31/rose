import 'package:app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => UserProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // home: Scaffold(
      //   body: Container(padding: EdgeInsets.all(10), child: Text("Arsh")),
      // ),
    );
  }
}
