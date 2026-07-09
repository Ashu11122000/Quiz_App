class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });
}

// Hardcoded structured data for the quiz
final List<Question> quizQuestions = [
  Question(
    text: 'What is the capital of France?',
    options: ['Berlin', 'Madrid', 'Paris', 'Rome'],
    correctAnswerIndex: 2,
  ),
  Question(
    text: 'Which programming language is used to build Flutter apps?',
    options: ['Java', 'Kotlin', 'Dart', 'Swift'],
    correctAnswerIndex: 2,
  ),
  Question(
    text: 'What is 8 multiplied by 7?',
    options: ['54', '56', '64', '49'],
    correctAnswerIndex: 1,
  ),
  Question(
    text: 'Which planet is known as the Red Planet?',
    options: ['Earth', 'Mars', 'Jupiter', 'Venus'],
    correctAnswerIndex: 1,
  ),
];