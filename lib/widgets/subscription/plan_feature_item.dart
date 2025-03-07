import 'package:flutter/material.dart';

class PlanFeatureItem extends StatelessWidget {
  final String text;
  final bool isIncluded;

  const PlanFeatureItem({
    super.key,
    required this.text,
    this.isIncluded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            isIncluded ? Icons.check_circle : Icons.cancel,
            color: isIncluded ? const Color(0xFF5CECC6) : Colors.red[400],
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isIncluded ? Colors.white : Colors.white70,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
