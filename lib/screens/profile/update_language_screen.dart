import 'package:flutter/material.dart';
import 'package:goodlov/widgets/update_screen_layout.dart';

class UpdateLanguageScreen extends StatefulWidget {
  final String? currentLanguage;

  const UpdateLanguageScreen({
    super.key,
    this.currentLanguage,
  });

  @override
  State<UpdateLanguageScreen> createState() => _UpdateLanguageScreenState();
}

class _UpdateLanguageScreenState extends State<UpdateLanguageScreen> {
  String? _selectedLanguage;

  final List<Map<String, String>> languages = [
    {'code': 'fr', 'name': 'Français', 'localName': 'French'},
    {'code': 'en', 'name': 'English', 'localName': 'English'},
    {'code': 'id', 'name': 'Indonesia', 'localName': 'Indonesian'},
    {
      'code': 'en-GB',
      'name': 'English (United Kingdom)',
      'localName': 'English'
    },
    {'code': 'it', 'name': 'Italiano', 'localName': 'Italian'},
    {'code': 'ms', 'name': 'Melayu', 'localName': 'Malay'},
    {'code': 'tr', 'name': 'Turkce', 'localName': 'Turkish'},
    {'code': 'nl', 'name': 'Nederlands', 'localName': 'Dutch'},
    {'code': 'de', 'name': 'Deutsch', 'localName': 'German'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.currentLanguage ?? 'en';
  }

  @override
  Widget build(BuildContext context) {
    return UpdateScreenLayout(
      title: 'Select Language',
      onUpdate: () {
        if (_selectedLanguage != null) {
          Navigator.pop(context, _selectedLanguage);
        }
      },
      child: Column(
        children: languages.map((language) {
          final isSelected = _selectedLanguage == language['code'];
          return InkWell(
            onTap: () {
              setState(() {
                _selectedLanguage = language['code'];
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withAlpha(25),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        language['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        language['localName']!,
                        style: TextStyle(
                          color: Colors.white.withAlpha(179),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF5CECC6),
                      size: 24,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
