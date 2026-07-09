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

// Expanded hardcoded structured data for the quiz
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
  Question(
    text: 'Which popular JavaScript library is maintained by Meta for building user interfaces?',
    options: ['Angular', 'Vue', 'Svelte', 'React'],
    correctAnswerIndex: 3,
  ),
  Question(
    text: 'Which platform is widely used to automate the deployment and scaling of containerized applications?',
    options: ['Docker', 'Vercel', 'Kubernetes', 'Railway'],
    correctAnswerIndex: 2,
  ),
  Question(
    text: 'In the context of modern AI, what does RAG stand for?',
    options: [
      'Random Access Generation', 
      'Retrieval-Augmented Generation', 
      'Rapid Algorithm Growth', 
      'Real-time Analytics Gateway'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    text: 'What is the chemical symbol for Gold?',
    options: ['Ag', 'Go', 'Au', 'Gd'],
    correctAnswerIndex: 2,
  ),
  Question(
    text: 'Which ocean is the largest on Earth?',
    options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
    correctAnswerIndex: 3,
  ),
  Question(
    text: 'Which data structure uses a Last-In, First-Out (LIFO) method?',
    options: ['Queue', 'Tree', 'Stack', 'Graph'],
    correctAnswerIndex: 2,
  ),
];