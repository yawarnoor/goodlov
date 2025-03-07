import 'package:flutter/material.dart';

class PlanHeader extends StatelessWidget {
  final String title;
  final Widget icon;
  final String description;

  const PlanHeader({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        icon,
        const SizedBox(height: 24),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
