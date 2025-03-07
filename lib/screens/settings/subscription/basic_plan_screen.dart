import 'package:flutter/material.dart';
import 'package:goodlov/widgets/subscription/plan_feature_item.dart';
import 'package:goodlov/widgets/subscription/plan_header.dart';

class BasicPlanScreen extends StatelessWidget {
  const BasicPlanScreen({super.key});

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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      PlanHeader(
                        title: 'Basic Membership',
                        icon: _buildBasicIcon(),
                        description:
                            'Basic members can create a profile take the GoodLov quiz, and start building their presence on the platform for free.',
                      ),
                      const PlanFeatureItem(text: 'Profile setup'),
                      const PlanFeatureItem(text: 'Only 1 profile picture'),
                      const PlanFeatureItem(text: 'Access to the quiz'),
                      const PlanFeatureItem(
                          text: 'Monthly emails with dating insights'),
                      const PlanFeatureItem(
                        text: 'No quiz results provided',
                        isIncluded: false,
                      ),
                      const PlanFeatureItem(
                        text: 'No access to matches',
                        isIncluded: false,
                      ),
                      const PlanFeatureItem(
                        text: 'No dedicated matchmaker',
                        isIncluded: false,
                      ),
                      const SizedBox(height: 40),
                      _buildSubscribeButton('Free'),
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

  Widget _buildBasicIcon() {
    return Image.asset(
      'assets/images/basic_plan.png',
      width: 120,
      height: 120,
    );
  }

  Widget _buildSubscribeButton(String price) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF5CECC6),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Center(
        child: Text(
          price,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
