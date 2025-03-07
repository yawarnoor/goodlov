import 'package:flutter/material.dart';
import 'package:goodlov/widgets/subscription/plan_feature_item.dart';
import 'package:goodlov/widgets/subscription/plan_header.dart';

class EssentialPlanScreen extends StatelessWidget {
  const EssentialPlanScreen({super.key});

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
                        title: 'Essential Membership',
                        icon: _buildEssentialIcon(),
                        description:
                            'Overview Essential members gain access to personalized quiz result and insights into their comparability profile.',
                      ),
                      const PlanFeatureItem(text: 'Profile setup'),
                      const PlanFeatureItem(text: 'Up to 1 profile picture'),
                      const PlanFeatureItem(
                          text: 'Full access to the quiz and results'),
                      const PlanFeatureItem(
                        text:
                            'Included in database for potential matches with ultimate clients',
                      ),
                      const PlanFeatureItem(
                        text: 'Monthly emails with dating insights',
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
                      _buildSubscribeButton('\$3.99/Month', '*\$40 annual'),
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

  Widget _buildEssentialIcon() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red[400]!.withAlpha(51),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Essential',
            style: TextStyle(
              color: Colors.red[400],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Membership',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const Text(
            'Plan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton(String price, String subtext) {
    return Column(
      children: [
        Container(
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
        ),
        const SizedBox(height: 8),
        Text(
          subtext,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
