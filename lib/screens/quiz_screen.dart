import 'dart:async';
import 'package:flutter/material.dart';
import '../models/question.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timeLeft = 15; // Increased slightly for better UX
  Timer? _timer;
  
  bool _isLocked = false;
  int? _selectedAnswerIndex;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timeLeft = 15;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer?.cancel();
          // Time's up, lock it and show correct answer
          _handleTimeUp();
        }
      });
    });
  }

  void _handleTimeUp() async {
    setState(() {
      _isLocked = true;
      _selectedAnswerIndex = -1; // -1 means time ran out
    });
    
    await Future.delayed(const Duration(seconds: 2));
    _goToNextQuestion();
  }

  void _handleAnswer(int selectedIndex) async {
    if (_isLocked) return;

    _timer?.cancel();
    
    setState(() {
      _isLocked = true;
      _selectedAnswerIndex = selectedIndex;
    });

    if (selectedIndex == quizQuestions[_currentQuestionIndex].correctAnswerIndex) {
      _score++;
    }

    // Pause so the user can see if they got it right or wrong
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));

    _goToNextQuestion();
  }

  void _goToNextQuestion() {
    if (_currentQuestionIndex < quizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _isLocked = false;
        _selectedAnswerIndex = null;
      });
      _startTimer();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: _score,
            totalQuestions: quizQuestions.length,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = quizQuestions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / quizQuestions.length;

    return Scaffold(
      // Premium Gradient Background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _timeLeft <= 3 ? Colors.redAccent.withOpacity(0.9) : Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.timer, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            '$_timeLeft s',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Progress Bar
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 12),
                Text(
                  'Question ${_currentQuestionIndex + 1} of ${quizQuestions.length}',
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
                ),
                const SizedBox(height: 30),

                // Question Card
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        currentQuestion.text,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Answer Options
                ...List.generate(currentQuestion.options.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildOption(index, currentQuestion.options[index]),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption(int index, String text) {
    final isCorrectAnswer = index == quizQuestions[_currentQuestionIndex].correctAnswerIndex;
    final isSelected = index == _selectedAnswerIndex;
    
    // Determine button colors based on state
    Color backgroundColor = Colors.white.withOpacity(0.9);
    Color borderColor = Colors.white;
    Color textColor = const Color(0xFF2D3142);
    IconData? icon;

    if (_isLocked) {
      if (isCorrectAnswer) {
        backgroundColor = Colors.green.shade400;
        borderColor = Colors.green;
        textColor = Colors.white;
        icon = Icons.check_circle;
      } else if (isSelected) {
        backgroundColor = Colors.red.shade400;
        borderColor = Colors.red;
        textColor = Colors.white;
        icon = Icons.cancel;
      }
    }

    return GestureDetector(
      onTap: () => _handleAnswer(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            if (icon != null) Icon(icon, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }
}