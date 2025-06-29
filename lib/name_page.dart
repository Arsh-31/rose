import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'date_page.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5E7),
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.4,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Enter your name to continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: controller,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(color: Colors.black),
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
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          Provider.of<UserProvider>(
                            context,
                            listen: false,
                          ).setName(controller.text.trim());

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const DatePage()),
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
        ),
      ),
    );
  }
}
