import 'package:flutter/material.dart';
import 'package:goodlov/screens/settings/subscription/basic_plan_screen.dart';
import 'package:goodlov/screens/settings/subscription/essential_plan_screen.dart';
import 'package:goodlov/screens/settings/subscription/premium_plan_screen.dart';
import 'package:goodlov/screens/settings/subscription/ultimate_plan_screen.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  const SubscriptionPlansScreen({super.key});

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
              _buildHeader(context),
              Container(
                height: 1,
                color: Colors.white.withAlpha(25),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildDiamondIcon(),
                        const SizedBox(height: 20),
                        const Text(
                          'Get',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          'Your PLANS',
                          style: TextStyle(
                            color: Color(0xFF5CECC6),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Choose your plan',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildPlanButton(
                          context,
                          'Basic',
                          'Free',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BasicPlanScreen(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildPlanButton(
                          context,
                          'Essential',
                          '\$ 3.99/Per Month',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EssentialPlanScreen(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildPlanButton(
                          context,
                          'Premium',
                          '\$13.99/Per Month',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PremiumPlanScreen(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildPlanButton(
                          context,
                          'Ultimate',
                          '\$4,400/One time',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UltimatePlanScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
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
        ],
      ),
    );
  }

  Widget _buildDiamondIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.red.withAlpha(51),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        Icons.diamond,
        size: 40,
        color: Colors.red[400],
      ),
    );
  }

  Widget _buildPlanButton(
    BuildContext context,
    String title,
    String price,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
