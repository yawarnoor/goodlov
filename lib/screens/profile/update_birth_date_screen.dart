import 'package:flutter/material.dart';
import 'package:goodlov/widgets/update_screen_layout.dart';
import 'package:goodlov/widgets/date_slider_widget.dart';

class UpdateBirthDateScreen extends StatefulWidget {
  final DateTime? currentDate;

  const UpdateBirthDateScreen({
    super.key,
    this.currentDate,
  });

  @override
  State<UpdateBirthDateScreen> createState() => _UpdateBirthDateScreenState();
}

class _UpdateBirthDateScreenState extends State<UpdateBirthDateScreen> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.currentDate;
  }

  @override
  Widget build(BuildContext context) {
    return UpdateScreenLayout(
      title: 'Date of birth',
      helperText: 'You can only change your date of birth once.',
      onUpdate: () {
        if (_selectedDate != null) {
          Navigator.pop(context, _selectedDate);
        }
      },
      child: DateSliderWidget(
        selectedDate: _selectedDate,
        onDateSelected: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }
}
