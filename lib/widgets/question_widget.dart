import 'package:flutter/material.dart';
import 'package:goodlov/models/questions.dart';
import 'package:goodlov/widgets/date_slider_widget.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final dynamic answer;
  final Function(dynamic) onAnswer;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.answer,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          _buildQuestionInput(context),
        ],
      ),
    );
  }

  Widget _buildQuestionInput(BuildContext context) {
    switch (question.type) {
      case QuestionType.text:
        return TextField(
          controller: TextEditingController(text: answer),
          onChanged: onAnswer,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Type here...',
            hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withAlpha(77)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF5CECC6)),
            ),
          ),
        );

      case QuestionType.radio:
      case QuestionType.multipleChoice:
        return Column(
          children: question.choices!
              .map((choice) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        radioTheme: RadioThemeData(
                          fillColor:
                              WidgetStateProperty.resolveWith<Color>((states) {
                            if (states.contains(WidgetState.selected)) {
                              return const Color(0xFF5CECC6);
                            }
                            return Colors.grey;
                          }),
                        ),
                      ),
                      child: RadioListTile<String>(
                        value: choice.id,
                        groupValue: answer,
                        onChanged: (value) => onAnswer(value),
                        title: Text(choice.text),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ))
              .toList(),
        );

      case QuestionType.dateSlider:
        return DateSliderWidget(
          onDateSelected: onAnswer,
          selectedDate: answer,
        );

      case QuestionType.imageChoice:
        return GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: question.choices!
              .map((choice) => GestureDetector(
                    onTap: () => onAnswer(choice.id),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: answer == choice.id
                                    ? const Color(0xFF5CECC6)
                                    : Colors.transparent,
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(choice.imageUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Theme(
                          data: Theme.of(context).copyWith(
                            radioTheme: RadioThemeData(
                              fillColor: WidgetStateProperty.resolveWith<Color>(
                                  (states) {
                                if (states.contains(WidgetState.selected)) {
                                  return const Color(0xFF5CECC6);
                                }
                                return Colors.grey;
                              }),
                            ),
                          ),
                          child: RadioListTile<String>(
                            value: choice.id,
                            groupValue: answer,
                            onChanged: (value) => onAnswer(value),
                            title: Text(choice.text,
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        );
    }
  }
}
