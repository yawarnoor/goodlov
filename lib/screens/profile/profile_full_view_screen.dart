import 'package:flutter/material.dart';
import 'package:goodlov/screens/profile/profile_preview_screen.dart';

class ProfileFullViewScreen extends StatelessWidget {
  const ProfileFullViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with close button and tabs
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Expanded(
                            child: Text(
                              'Leo',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Already in preview mode
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xFF5CECC6),
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Preview',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF5CECC6),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Switch to edit mode by navigating to profile preview screen
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ProfilePreviewScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: const Text(
                                'Edit',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Profile content - full screen image with status chips
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/leo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Status chips at the bottom
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 32,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Leo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _buildStatusChip(
                                  icon: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF5CECC6),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  label: 'Active Today',
                                ),
                                _buildStatusChip(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 12,
                                  ),
                                  label: 'Compatibility: 85%',
                                ),
                                _buildStatusChip(
                                  icon: const Text('🇬🇧',
                                      style: TextStyle(fontSize: 12)),
                                  label: 'United Kingdom',
                                ),
                                _buildStatusChip(
                                  icon: const Icon(
                                    Icons.work_outline,
                                    color: Color(0xFF5CECC6),
                                    size: 12,
                                  ),
                                  label: 'Businessman',
                                ),
                                _buildStatusChip(
                                  icon: const Icon(
                                    Icons.cake,
                                    color: Colors.amber,
                                    size: 12,
                                  ),
                                  label: 'Age 22',
                                ),
                                _buildStatusChip(
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.pink,
                                    size: 12,
                                  ),
                                  label: 'Never Married',
                                ),
                                _buildStatusChip(
                                  icon: const Text('🥾',
                                      style: TextStyle(fontSize: 12)),
                                  label: 'Hiking',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip({required Widget icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
