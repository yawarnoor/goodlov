import 'package:flutter/material.dart';
import 'package:goodlov/models/questions.dart';
import 'package:goodlov/models/user.dart';
import 'package:goodlov/screens/error_screen.dart';
import 'package:goodlov/screens/result_screen.dart';
import 'package:goodlov/widgets/question_widget.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int currentQuestionIndex = 0;
  Map<String, dynamic> answers = {};
  String? error;

  final List<Question> questions = [
    Question(
      id: 'name',
      question: "What's your name?",
      type: QuestionType.text,
      questionNumber: 1,
      totalQuestions: 20,
    ),
    Question(
      id: 'gender',
      question: "Are you a man or a woman?",
      type: QuestionType.radio,
      choices: [
        Choice(id: 'man', text: 'I am a man'),
        Choice(id: 'woman', text: 'I am a woman'),
      ],
      questionNumber: 2,
      totalQuestions: 20,
    ),
    Question(
      id: 'age',
      question: "How old are you?",
      type: QuestionType.dateSlider,
      questionNumber: 3,
      totalQuestions: 20,
    ),
    Question(
      id: 'personality',
      question: "What describes you best?",
      type: QuestionType.multipleChoice,
      choices: [
        Choice(id: 'outgoing', text: 'Outgoing'),
        Choice(id: 'introverted', text: 'Introverted'),
        Choice(id: 'ambivert', text: 'Ambivert'),
        Choice(id: 'analytical', text: 'Analytical'),
      ],
      questionNumber: 4,
      totalQuestions: 20,
    ),
    Question(
      id: 'conflict_handling',
      question: "How do you usually handle conflicts in relationships?",
      type: QuestionType.multipleChoice,
      choices: [
        Choice(id: 'avoid', text: 'I avoid conflict together.'),
        Choice(id: 'discuss', text: 'I try to discuss and resolve it calmly.'),
        Choice(
            id: 'express', text: 'I express my feelings openly and directly.'),
        Choice(id: 'time', text: 'I need time before addressing issues'),
      ],
      questionNumber: 5,
      totalQuestions: 20,
    ),
    Question(
      id: 'weekend',
      question: "How do you prefer to spend your weekends?",
      type: QuestionType.multipleChoice,
      choices: [
        Choice(id: 'home', text: 'Relaxing at home'),
        Choice(id: 'explore', text: 'Exploring new places'),
        Choice(id: 'social', text: 'Spending time with friends or family.'),
        Choice(id: 'hobbies', text: 'Engaging in hobbies or sports'),
      ],
      questionNumber: 6,
      totalQuestions: 20,
    ),
    Question(
      id: 'destination',
      question: "Pick a destination you'd love to visit.",
      type: QuestionType.imageChoice,
      choices: [
        Choice(
          id: 'beach',
          text: 'Beach',
          imageUrl: 'assets/images/beach.png',
        ),
        Choice(
          id: 'city',
          text: 'City',
          imageUrl: 'assets/images/city.png',
        ),
        Choice(
          id: 'mountains',
          text: 'Mountains',
          imageUrl: 'assets/images/mountains.png',
        ),
        Choice(
          id: 'desert',
          text: 'Desert',
          imageUrl: 'assets/images/desert.png',
        ),
      ],
      questionNumber: 7,
      totalQuestions: 7,
    ),
  ];

  void handleAnswer(String questionId, dynamic answer) {
    setState(() {
      answers[questionId] = answer;
      error = null;
    });
  }

  void handleNext() {
    if (answers[questions[currentQuestionIndex].id] == null) {
      setState(() {
        error = 'Please answer the question to continue';
      });
      showErrorScreen();
      return;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        error = null;
      });
    } else {
      // Last question answered, show results
      // Create a default name if none was provided
      final name = answers['name'] ?? 'User';

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            user: User(
              id: '1',
              name: name,
              profileImage:
                  'assets/images/leo.png', // Add a default profile image
              personalityTraits: {
                'Innovative': 0.8,
                'Explorer': 0.6,
                'Strategist': 0.9,
                'Visionary': 0.7,
                'Socializer': 0.5,
                'Negotiator': 0.75,
                'Builder': 0.85,
                'Engineer': 0.95,
              },
              isNewUser: false,
            ),
          ),
        ),
      );
    }
  }

  void showErrorScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ErrorScreen(
          question: questions[currentQuestionIndex].question,
          onReturn: () => Navigator.pop(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2D2438),
              Color(0xFF2D8B96),
              Color(0xFF1A2E35),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button and progress
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        if (currentQuestionIndex > 0) {
                          setState(() {
                            currentQuestionIndex--;
                          });
                        }
                      },
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        value:
                            question.questionNumber / question.totalQuestions,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF5CECC6)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${question.questionNumber} to ${question.totalQuestions}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: QuestionWidget(
                  question: question,
                  answer: answers[question.id],
                  onAnswer: (answer) => handleAnswer(question.id, answer),
                ),
              ),

              // Next button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: handleNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5CECC6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
