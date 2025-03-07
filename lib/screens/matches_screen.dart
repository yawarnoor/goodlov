import 'package:flutter/material.dart';
import 'package:goodlov/models/match_profile.dart';
import 'package:goodlov/screens/filter_screen.dart';
import 'package:goodlov/widgets/match_card.dart';
import 'package:goodlov/screens/profile_creation_screen.dart';
import 'package:goodlov/screens/user_profile_screen.dart';
import 'package:goodlov/config/app_config.dart'; // Import the config
import 'package:goodlov/widgets/bottom_navbar.dart'; // Import the navbar

class MatchesScreen extends StatefulWidget {
  final bool hasCompletedProfile;
  final int currentTab;
  final Function(int) onTabChanged;

  const MatchesScreen({
    super.key,
    required this.hasCompletedProfile,
    required this.currentTab,
    required this.onTabChanged,
  });

  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  late List<MatchProfile> profiles;
  int currentIndex = 0;
  late bool _hasCompletedProfile;

  @override
  void initState() {
    super.initState();
    profiles = MatchProfile.getSampleProfiles();
    _hasCompletedProfile = widget.hasCompletedProfile;
    print(
        'MatchesScreen initialized with hasCompletedProfile: $_hasCompletedProfile');
  }

  void handleAction(String action) {
    if (currentIndex < profiles.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void _navigateToProfileCreation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileCreationScreen(),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _hasCompletedProfile = true;
        // Also update the global config
        AppConfig.hasCompletedProfile = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile created successfully!'),
          backgroundColor: Color(0xFF5CECC6),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomHeight = MediaQuery.of(context).size.height * 0.1;

    // Debug print to verify the condition
    if (!_hasCompletedProfile) {
      print('Should show create profile banner: true');
    } else {
      print('Should show create profile banner: false');
    }

    return Container(
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
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (profiles.isNotEmpty && currentIndex < profiles.length)
            Positioned.fill(
              bottom: bottomHeight,
              child: MatchCard(
                profile: profiles[currentIndex],
                onAction: handleAction,
              ),
            ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(51),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FilterScreen(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(51),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    onPressed: () {
                      if (profiles.isNotEmpty &&
                          currentIndex < profiles.length) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileScreen(
                              profile: {
                                'name': profiles[currentIndex].name,
                                'image': profiles[currentIndex].imageUrl,
                                'bio': profiles[currentIndex].bio,
                                'hobbies': profiles[currentIndex].hobbies,
                                'traits': profiles[currentIndex].traits,
                                'isActiveToday':
                                    profiles[currentIndex].isActiveToday,
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          // Only show the "Create profile now" prompt if user hasn't completed profile
          // IMPORTANT: This is rendered BEFORE the navbar to ensure proper stacking
          if (!_hasCompletedProfile)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: bottomHeight,
              child: GestureDetector(
                onTap: _navigateToProfileCreation,
                child: Container(
                  color: const Color(0xFF1A2E35),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Create profile now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // Add the navbar to the MatchesScreen
          // This is rendered AFTER the banner to ensure the banner is visible
          if (_hasCompletedProfile) // Only show navbar if profile is completed
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BottomNavbar(
                currentIndex: widget.currentTab,
                onTap: widget.onTabChanged,
              ),
            ),
        ],
      ),
    );
  }
}
