import 'package:flutter/material.dart';
import 'package:goodlov/screens/settings/privacy_security_screen.dart';
import 'package:goodlov/screens/settings/notifications_screen.dart';
import 'package:goodlov/screens/settings/language_screen.dart';
import 'package:goodlov/screens/settings/help_support_screen.dart';
import 'package:goodlov/screens/settings/subscription_plans_screen.dart';

class SettingsScreen extends StatelessWidget {
  final int currentTab;
  final Function(int) onTabChanged;
  final bool isNewUser;

  const SettingsScreen({
    super.key,
    required this.currentTab,
    required this.onTabChanged,
    this.isNewUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isNewUser) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE94FA8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'New User',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colors.white.withAlpha(25),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    _buildProfileSection(),
                    const SizedBox(height: 20),
                    _buildSettingItem(
                      context,
                      'Privacy & Security',
                      Icons.lock_outline,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacySecurityScreen(),
                        ),
                      ),
                    ),
                    _buildSettingItem(
                      context,
                      'Notifications',
                      Icons.notifications_none,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsScreen(),
                        ),
                      ),
                    ),
                    _buildSettingItem(
                      context,
                      'Subscription & Membership',
                      Icons.card_membership,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubscriptionPlansScreen(),
                        ),
                      ),
                    ),
                    _buildSettingItem(
                      context,
                      'Language settings',
                      Icons.language,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LanguageScreen(),
                        ),
                      ),
                    ),
                    _buildSettingItem(
                      context,
                      'Help & Support',
                      Icons.help_outline,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HelpSupportScreen(),
                        ),
                      ),
                    ),
                    _buildSettingItem(
                      context,
                      'Logout',
                      Icons.logout,
                      () {
                        // Handle logout
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.1), // Space for navbar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40, // Larger avatar
              backgroundColor: Colors.grey[300],
              child: const Icon(
                Icons.person,
                size: 50, // Adjusted icon size
                color: Colors.grey,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 20, // Slightly larger for the pencil icon
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF5CECC6),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        const Text(
          'Leo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
        ),
        Container(
          height: 1,
          color: Colors.white.withAlpha(25),
        ),
      ],
    );
  }
}
