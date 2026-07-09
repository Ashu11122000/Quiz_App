import 'package:flutter/material.dart';
import 'screens/quiz_screen.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premium Quiz App',
      debugShowCheckedModeBanner: false, // Hides the debug banner for a cleaner look
      theme: ThemeData(
        // Aligns default app colors with your new purple gradient UI
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A00E0),
        ),
        useMaterial3: true,
      ),
      home: const QuizScreen(),
    );
  }
}