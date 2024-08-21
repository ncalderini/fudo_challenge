import 'package:flutter/material.dart';
import 'package:fudo_challenge/presentation/login/view/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fudo Challenge',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            // Specify custom colors for the dark theme.
            primary: Colors.black,
            surface: Colors.orange.shade600,
          ),
          useMaterial3: true,
        ),
        home: const LoginPage());
  }
}
