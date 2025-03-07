import 'package:flutter/material.dart';
import 'package:goodlov/widgets/update_screen_layout.dart';

class UpdateInterestsScreen extends StatefulWidget {
  final List<String>? selectedInterests;

  const UpdateInterestsScreen({
    super.key,
    this.selectedInterests,
  });

  @override
  State<UpdateInterestsScreen> createState() => _UpdateInterestsScreenState();
}

class _UpdateInterestsScreenState extends State<UpdateInterestsScreen> {
  late Set<String> _selectedInterests;

  final Map<String, List<Map<String, dynamic>>> interestCategories = {
    'Hobbies & Activities': [
      {'id': 'travelling', 'text': 'Travelling', 'emoji': '🌍'},
      {'id': 'hiking', 'text': 'Hiking', 'emoji': '🥾'},
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
      {'id': 'baking', 'text': 'Baking', 'emoji': '🥖'},
      {'id': 'vegan', 'text': 'Vegan', 'emoji': '🌱'},
      {'id': 'coffee', 'text': 'Coffee', 'emoji': '☕'},
      {'id': 'desserts', 'text': 'Desserts', 'emoji': '🍰'},
      {'id': 'spice_lover', 'text': 'Spice Lover', 'emoji': '🌶️'},
      {'id': 'barbeque', 'text': 'Barbeque', 'emoji': '🍖'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedInterests = widget.selectedInterests?.toSet() ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return UpdateScreenLayout(
      title: 'Interests',
      onUpdate: () {
        Navigator.pop(context, _selectedInterests.toList());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: interestCategories.entries.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.key,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: category.value.map((interest) {
                  final isSelected =
                      _selectedInterests.contains(interest['id']);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedInterests.remove(interest['id']);
                        } else {
                          _selectedInterests.add(interest['id']);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF5CECC6).withAlpha(76)
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
                          const SizedBox(width: 6),
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
        }).toList(),
      ),
    );
  }
}
