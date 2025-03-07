import 'package:flutter/material.dart';
import 'package:goodlov/models/profile_data.dart';
import 'package:goodlov/screens/profile/location_screen.dart';
import 'package:goodlov/screens/profile/update_name_screen.dart';
import 'package:goodlov/screens/profile/update_birth_date_screen.dart';
import 'package:goodlov/screens/profile/update_gender_screen.dart';
import 'package:goodlov/screens/profile/update_interests_screen.dart';
import 'package:goodlov/screens/profile/update_language_screen.dart';
import 'package:goodlov/screens/profile/profile_avatar_modal.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Initialize with some default data
  final ProfileData _profileData = ProfileData(
    firstName: 'Leo',
    dateOfBirth: DateTime(1999, 9, 12),
    gender: 'Male',
    location: 'London, UK',
    interests: ['running', 'hiking', 'coffee'],
    language: 'en',
  );

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
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Profile Setup',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        // Profile Photo
                        GestureDetector(
                          onTap: () => _showAvatarOptions(context),
                          child: Stack(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=200&auto=format&fit=crop',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE94FA8),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Name
                        Text(
                          _profileData.firstName ?? 'Add Name',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Profile Fields
                        _buildProfileField(
                          'First Name',
                          _profileData.firstName ?? 'Enter name',
                          onTap: () => _navigateToNameUpdate(),
                        ),
                        _buildProfileField(
                          'Date of birth',
                          _profileData.getFormattedDateOfBirth(),
                          onTap: () => _navigateToBirthDateUpdate(),
                        ),
                        _buildProfileField(
                          'Gender',
                          _profileData.gender ?? 'Select gender',
                          onTap: () => _navigateToGenderUpdate(),
                        ),
                        _buildProfileField(
                          'Location',
                          _profileData.location ?? 'Enter location',
                          onTap: () => _navigateToLocationUpdate(),
                        ),
                        _buildProfileField(
                          'Interests',
                          _profileData.getFormattedInterests(),
                          onTap: () => _navigateToInterestsUpdate(),
                        ),
                        _buildProfileField(
                          'Language',
                          _profileData.getLanguageName(),
                          onTap: () => _navigateToLanguageUpdate(),
                        ),
                        // View Full Profile Button Removed
                      ],
                    ),
                  ),
                ),
              ),
              // Space for bottom navbar
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  void _showAvatarOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ProfileAvatarModal(
        onImageSourceSelected: (source) {
          // Handle image source selection
          if (source == ImageSource.camera) {
            // Handle camera
            print('Camera selected');
          } else {
            // Handle gallery
            print('Gallery selected');
          }
        },
      ),
    );
  }

  Widget _buildProfileField(
    String label,
    String value, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white.withOpacity(0.6),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  // Navigation methods
  Future<void> _navigateToNameUpdate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateNameScreen(
          currentName: _profileData.firstName ?? '',
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _profileData.firstName = result;
      });
    }
  }

  Future<void> _navigateToBirthDateUpdate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateBirthDateScreen(
          currentDate: _profileData.dateOfBirth,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _profileData.dateOfBirth = result;
      });
    }
  }

  Future<void> _navigateToGenderUpdate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateGenderScreen(
          currentGender: _profileData.gender,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _profileData.gender = result;
      });
    }
  }

  Future<void> _navigateToLocationUpdate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocationScreen(),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _profileData.location = result;
      });
    }
  }

  Future<void> _navigateToInterestsUpdate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateInterestsScreen(
          selectedInterests: _profileData.interests,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _profileData.interests = result;
      });
    }
  }

  Future<void> _navigateToLanguageUpdate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateLanguageScreen(
          currentLanguage: _profileData.language,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _profileData.language = result;
      });
    }
  }
}
