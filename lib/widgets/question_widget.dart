import 'package:flutter/material.dart';
import 'package:goodlov/models/questions.dart';
import 'package:goodlov/widgets/date_slider_widget.dart';

class QuestionWidget extends StatefulWidget {
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
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.answer);
  }

  @override
  void didUpdateWidget(QuestionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.answer != oldWidget.answer &&
        widget.question.type == QuestionType.text) {
      _textController.text = widget.answer ?? '';
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question.question,
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
    switch (widget.question.type) {
      case QuestionType.text:
        return TextField(
          controller: _textController,
          onChanged: widget.onAnswer,
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
          children: widget.question.choices!
              .map((choice) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: RadioListTile<String>(
                      value: choice.id,
                      groupValue: widget.answer,
                      onChanged: (value) => widget.onAnswer(value),
                      title: Text(choice.text),
                      activeColor: const Color(0xFF5CECC6),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ))
              .toList(),
        );

      case QuestionType.dateSlider:
        return DateSliderWidget(
          onDateSelected: widget.onAnswer,
          selectedDate: widget.answer,
        );

      case QuestionType.imageChoice:
        return GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: widget.question.choices!
              .map((choice) => GestureDetector(
                    onTap: () => widget.onAnswer(choice.id),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: widget.answer == choice.id
                                    ? const Color(0xFF5CECC6)
                                    : Colors.transparent,
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: AssetImage(choice.imageUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        RadioListTile<String>(
                          value: choice.id,
                          groupValue: widget.answer,
                          onChanged: (value) => widget.onAnswer(value),
                          title: Text(choice.text,
                              style: const TextStyle(color: Colors.white)),
                          activeColor: const Color(0xFF5CECC6),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        );
    }
  }
}
