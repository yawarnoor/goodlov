enum QuestionType { text, radio, dateSlider, multipleChoice, imageChoice }

class Question {
  final String id;
  final String question;
  final QuestionType type;
  final List<Choice>? choices;
  final bool isRequired;
  final int questionNumber;
  final int totalQuestions;

  Question({
    required this.id,
    required this.question,
    required this.type,
    this.choices,
    this.isRequired = true,
    required this.questionNumber,
    required this.totalQuestions,
  });
}

class Choice {
  final String id;
  final String text;
  final String? imageUrl;

  Choice({
    required this.id,
    required this.text,
    this.imageUrl,
  });
}
