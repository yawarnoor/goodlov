import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodlov/models/questions.dart';
import 'package:goodlov/models/user.dart';
import 'package:goodlov/models/edit_type.dart';
import 'package:goodlov/screens/error_screen.dart';

class ProfileCreationScreen extends StatefulWidget {
  final EditType? initialStep;
  final bool isEditing;

  const ProfileCreationScreen({
    super.key,
    this.initialStep,
    this.isEditing = false,
  });

  @override
  _ProfileCreationScreenState createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  int currentQuestionIndex = 0;
  Map<String, dynamic> answers = {};

  final Map<String, List<Map<String, dynamic>>> interestCategories = {
    'Hobbies & Activities': [
      {'id': 'travelling', 'text': 'Travelling', 'emoji': '🏠'},
      {'id': 'hiking', 'text': 'Hiking', 'emoji': '🏃'},
      {'id': 'reading', 'text': 'Reading', 'emoji': '📚'},
      {'id': 'cooking', 'text': 'Cooking', 'emoji': '🍳'},
      {'id': 'photography', 'text': 'Photography', 'emoji': '📸'},
      {'id': 'writing', 'text': 'Writing', 'emoji': '✍️'},
      {'id': 'gaming', 'text': 'Gaming', 'emoji': '🎮'},
    ],
    'Sports & Fitness': [
      {'id': 'yoga', 'text': 'Yoga', 'emoji': '🧘‍♀️'},
      {'id': 'running', 'text': 'Running', 'emoji': '🏃‍♂️'},
      {'id': 'cycling', 'text': 'Cycling', 'emoji': '🚴‍♂️'},
      {'id': 'soccer', 'text': 'Soccer', 'emoji': '⚽'},
      {'id': 'cricket', 'text': 'Cricket', 'emoji': '🏏'},
      {'id': 'tennis', 'text': 'Tennis', 'emoji': '🎾'},
      {'id': 'basketball', 'text': 'Basketball', 'emoji': '🏀'},
    ],
    'Entertainment': [
      {'id': 'movies', 'text': 'Movies', 'emoji': '🎬'},
      {'id': 'tv_shows', 'text': 'TV Shows', 'emoji': '📺'},
      {'id': 'music', 'text': 'Music', 'emoji': '🎵'},
      {'id': 'theater', 'text': 'Theater', 'emoji': '🎭'},
      {'id': 'standup', 'text': 'Stand-Up', 'emoji': '🎤'},
      {'id': 'anime', 'text': 'Anime', 'emoji': '🎨'},
    ],
    'Food & Drinks': [
      {'id': 'foodie', 'text': 'Foodie', 'emoji': '🍽️'},
      {'id': 'wine', 'text': 'Wine', 'emoji': '🍷'},
      {'id': 'craft_beer', 'text': 'Craft Beer', 'emoji': '🍺'},
      {'id': 'coffee', 'text': 'Coffee', 'emoji': '☕'},
      {'id': 'baking', 'text': 'Baking', 'emoji': '🥖'},
      {'id': 'vegetarian', 'text': 'Vegetarian', 'emoji': '🥗'},
      {'id': 'vegan', 'text': 'Vegan', 'emoji': '🌱'},
    ],
  };

  final List<Question> questions = [
    Question(
      id: 'profession',
      question: "What's your profession?",
      type: QuestionType.radio,
      choices: [
        Choice(id: 'author', text: 'Author'),
        Choice(id: 'baker', text: 'Baker'),
        Choice(id: 'chef', text: 'Chef'),
        Choice(id: 'doctor', text: 'Doctor'),
        Choice(id: 'driver', text: 'Driver'),
        Choice(id: 'electrician', text: 'Electrician'),
        Choice(id: 'government', text: 'Government Employee'),
        Choice(id: 'finance', text: 'Finance Professional'),
        Choice(id: 'health', text: 'Health & Beauty Employee'),
      ],
      questionNumber: 9,
      totalQuestions: 20,
    ),
    Question(
      id: 'education',
      question: "What's your Education level?",
      type: QuestionType.radio,
      choices: [
        Choice(id: 'secondary', text: 'Secondary school'),
        Choice(id: 'non_degree', text: 'Non-degree qualification'),
        Choice(id: 'bachelors', text: 'Bachelors degree'),
        Choice(id: 'masters', text: 'Masters degree'),
        Choice(id: 'doctorate', text: 'Doctorate'),
        Choice(id: 'other', text: 'Other education level'),
      ],
      questionNumber: 10,
      totalQuestions: 20,
    ),
    Question(
      id: 'photos',
      question: "Upload Photos",
      type: QuestionType.imageChoice,
      isRequired: false,
      questionNumber: 11,
      totalQuestions: 20,
    ),
    Question(
      id: 'interests',
      question: "Select your interests",
      type: QuestionType.multipleChoice,
      choices: [
        Choice(id: 'travelling', text: 'Travelling'),
        Choice(id: 'hiking', text: 'Hiking'),
        Choice(id: 'reading', text: 'Reading'),
        Choice(id: 'cooking', text: 'Cooking'),
        Choice(id: 'photography', text: 'Photography'),
        Choice(id: 'writing', text: 'Writing'),
        Choice(id: 'gaming', text: 'Gaming'),
        Choice(id: 'yoga', text: 'Yoga'),
        Choice(id: 'running', text: 'Running'),
        Choice(id: 'cycling', text: 'Cycling'),
        Choice(id: 'soccer', text: 'Soccer'),
        Choice(id: 'cricket', text: 'Cricket'),
        Choice(id: 'tennis', text: 'Tennis'),
        Choice(id: 'basketball', text: 'Basketball'),
        Choice(id: 'movies', text: 'Movies'),
        Choice(id: 'tv_shows', text: 'TV Shows'),
        Choice(id: 'music', text: 'Music'),
        Choice(id: 'theater', text: 'Theater'),
        Choice(id: 'standup', text: 'Stand-Up'),
        Choice(id: 'anime', text: 'Anime'),
        Choice(id: 'foodie', text: 'Foodie'),
        Choice(id: 'wine', text: 'Wine'),
        Choice(id: 'craft_beer', text: 'Craft Beer'),
        Choice(id: 'coffee', text: 'Coffee'),
        Choice(id: 'baking', text: 'Baking'),
        Choice(id: 'vegetarian', text: 'Vegetarian'),
        Choice(id: 'vegan', text: 'Vegan'),
      ],
      questionNumber: 12,
      totalQuestions: 20,
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialStep != null) {
      // Set the current question index based on the edit type
      currentQuestionIndex = _getQuestionIndexForEditType(widget.initialStep!);
    }
  }

  int _getQuestionIndexForEditType(EditType type) {
    switch (type) {
      case EditType.firstName:
        return 0;
      case EditType.dateOfBirth:
        return 1;
      case EditType.gender:
        return 2;
      case EditType.location:
        return 3;
      case EditType.interests:
        return 4;
      case EditType.language:
        return 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () {
            if (currentQuestionIndex > 0) {
              setState(() {
                currentQuestionIndex--;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          '${questions[currentQuestionIndex].questionNumber} to ${questions[currentQuestionIndex].totalQuestions}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
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
              _buildProgressBar(),
              Expanded(
                child: _buildCurrentQuestion(),
              ),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: List.generate(
          8,
          (index) => Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: index < 3
                    ? const Color(0xFF5CECC6)
                    : Colors.white.withAlpha(76),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentQuestion() {
    final question = questions[currentQuestionIndex];
    if (question.type == QuestionType.multipleChoice) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select your interest',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            ...interestCategories.entries.map((category) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.key,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: category.value.map((interest) {
                      final isSelected = (answers['interests'] as List<String>?)
                              ?.contains(interest['id']) ??
                          false;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            final List<String> selectedInterests =
                                (answers['interests'] as List<String>?) ?? [];
                            if (isSelected) {
                              selectedInterests.remove(interest['id']);
                            } else {
                              selectedInterests.add(interest['id']);
                            }
                            answers['interests'] = selectedInterests;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF5CECC6).withAlpha(51)
                                : Colors.white.withAlpha(51),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                interest['emoji'],
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                interest['text'],
                                style: TextStyle(
                                  color: isSelected
                                      ? const Color(0xFF5CECC6)
                                      : Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            }),
          ],
        ),
      );
    }
    final question2 = questions[currentQuestionIndex];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question2.question,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          if (question2.type == QuestionType.radio)
            _buildRadioQuestion(question2)
          else if (question2.type == QuestionType.imageChoice)
            _buildImageUploadQuestion(question2)
        ],
      ),
    );
  }

  Widget _buildRadioQuestion(Question question) {
    return Column(
      children: question.choices
              ?.map((choice) => _buildRadioOption(
                    question.id,
                    choice.id,
                    choice.text,
                    answers[question.id] == choice.id,
                    () {
                      setState(() {
                        answers[question.id] = choice.id;
                      });
                    },
                  ))
              .toList() ??
          [],
    );
  }

  Widget _buildRadioOption(String questionId, String choiceId, String text,
      bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF5CECC6) : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Color(0xFF5CECC6),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadQuestion(Question question) {
    return const Center(
      child: Text(
        'Image upload feature coming soon!',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _handleContinue,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5CECC6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  void _handleContinue() {
    final currentQuestion = questions[currentQuestionIndex];
    if (currentQuestion.type == QuestionType.multipleChoice) {
      final List<String> selectedInterests =
          (answers['interests'] as List<String>?) ?? [];
      if (selectedInterests.isEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorScreen(
              question: 'Please select at least one interest to continue',
              onReturn: () => Navigator.pop(context),
            ),
          ),
        );
        return;
      }
    }
    if (currentQuestion.isRequired && answers[currentQuestion.id] == null) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please answer the question to continue')),
      );
      return;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Profile creation completed
      _completeProfileCreation();
    }
  }

  void _completeProfileCreation() {
    // Create a new user with the collected data
    final newUser = User(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(), // Generate a unique ID
      name:
          'New User', // You might want to add a name question to your profile creation
      personalityTraits: {}, // You can add personality traits based on the answers if needed
      isNewUser: false,
    );

    // Here you would typically save the user data to your backend
    // For now, we'll just print the data and return to the previous screen
    print('New user created: ${newUser.id}');
    print('Answers: $answers');

    // Return to the previous screen with the new user data
    Navigator.pop(context, newUser);
  }
}
