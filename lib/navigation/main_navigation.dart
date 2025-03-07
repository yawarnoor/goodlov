import 'package:flutter/material.dart';
import 'package:goodlov/screens/matches_screen.dart';
import 'package:goodlov/screens/discover_screen.dart';
import 'package:goodlov/screens/chat_list_screen.dart';
import 'package:goodlov/screens/settings/settings_screen.dart';
import 'package:goodlov/screens/profile_screen.dart';
import 'package:goodlov/widgets/bottom_navbar.dart';
import 'package:goodlov/config/app_config.dart'; // Import the config

class MainNavigation extends StatefulWidget {
  final int initialTab;

  const MainNavigation({
    super.key,
    this.initialTab = 0,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _currentTab;

  @override
  void initState() {
    super.initState();
    _currentTab = widget.initialTab;
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Debug info overlay if enabled
    if (AppConfig.showDebugInfo) {
      print(
          'App Config: hasCompletedProfile=${AppConfig.hasCompletedProfile}, isNewUser=${AppConfig.isNewUser}');
    }

    return Scaffold(
      body: Stack(
        children: [
          // Main content based on selected tab
          _buildCurrentScreen(),

          // Bottom navigation bar - only for non-matches tabs
          // For the matches tab, the navbar is rendered inside the MatchesScreen
          if (_currentTab != 0) // Don't show navbar for matches tab
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BottomNavbar(
                currentIndex: _currentTab,
                onTap: _onTabChanged,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentTab) {
      case 0:
        // Use the global config for hasCompletedProfile
        // Add debug print to verify the value being passed
        print(
            'MainNavigation passing hasCompletedProfile: ${AppConfig.hasCompletedProfile}');

        // Pass the current tab and tab change callback to MatchesScreen
        return MatchesScreen(
          hasCompletedProfile: AppConfig.hasCompletedProfile,
          currentTab: _currentTab,
          onTabChanged: _onTabChanged,
        );
      case 1:
        return DiscoverScreen(
          onStartExploring: () {
            setState(() {
              _currentTab = 0;
            });
          },
        );
      case 2:
        return const ChatListScreen();
      case 3:
        return SettingsScreen(
          currentTab: _currentTab,
          onTabChanged: _onTabChanged,
        );
      case 4:
        return const ProfileScreen();
      default:
        return MatchesScreen(
          hasCompletedProfile: AppConfig.hasCompletedProfile,
          currentTab: _currentTab,
          onTabChanged: _onTabChanged,
        );
    }
  }
}
