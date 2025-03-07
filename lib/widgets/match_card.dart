import 'package:flutter/material.dart';
import 'package:goodlov/models/match_profile.dart';
import 'package:goodlov/widgets/action_button.dart';

class MatchCard extends StatelessWidget {
  final MatchProfile profile;
  final Function(String) onAction;

  const MatchCard({
    super.key,
    required this.profile,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Profile Image
          Image.asset(
            profile.imageUrl,
            fit: BoxFit.cover,
          ),

          // Gradient Overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(204),
                  ],
                ),
              ),
            ),
          ),

          // Profile Info
          Positioned(
            bottom: 140, // Increased to make room for action buttons
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildChip(
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
                    _buildChip(
                      icon: const Icon(Icons.favorite,
                          color: Colors.red, size: 16),
                      label: 'Compatibility: ${profile.compatibilityScore}%',
                    ),
                    _buildChip(
                      icon: Image.asset(
                        'assets/images/uk_flag.png',
                        width: 16,
                        height: 16,
                      ),
                      label: profile.location,
                    ),
                    _buildChip(
                      icon: const Icon(Icons.work_outline,
                          color: Color(0xFF5CECC6), size: 16),
                      label: profile.occupation,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
          Positioned(
            bottom: 20, // Adjusted to be above the navbar
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionButton(
                  icon: Icons.close,
                  color: Colors.pink,
                  onTap: () => onAction('dislike'),
                ),
                ActionButton(
                  icon: Icons.star,
                  color: Colors.black,
                  onTap: () => onAction('superlike'),
                ),
                ActionButton(
                  icon: Icons.favorite,
                  color: const Color(0xFF5CECC6),
                  onTap: () => onAction('like'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip({required Widget icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(153),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
