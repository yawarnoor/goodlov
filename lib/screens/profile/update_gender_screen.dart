import 'package:flutter/material.dart';
import 'package:goodlov/widgets/update_screen_layout.dart';

class UpdateGenderScreen extends StatefulWidget {
  final String? currentGender;

  const UpdateGenderScreen({
    super.key,
    this.currentGender,
  });

  @override
  State<UpdateGenderScreen> createState() => _UpdateGenderScreenState();
}

class _UpdateGenderScreenState extends State<UpdateGenderScreen> {
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.currentGender;
  }

  @override
  Widget build(BuildContext context) {
    return UpdateScreenLayout(
      title: 'Gender',
      onUpdate: () {
        if (_selectedGender != null) {
          Navigator.pop(context, _selectedGender);
        }
      },
      child: Column(
        children: [
          _buildGenderOption('Male'),
          const SizedBox(height: 16),
          _buildGenderOption('Female'),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    final isSelected = _selectedGender == gender;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(25),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              gender,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                color: Color(0xFF5CECC6),
              ),
          ],
        ),
      ),
    );
  }
}
