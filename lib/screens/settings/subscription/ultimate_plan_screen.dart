import 'package:flutter/material.dart';
import 'package:goodlov/widgets/subscription/plan_feature_item.dart';
import 'package:goodlov/widgets/subscription/plan_header.dart';

class UltimatePlanScreen extends StatelessWidget {
  const UltimatePlanScreen({super.key});

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
                        title: 'Ultimate Membership',
                        icon: _buildUltimateIcon(),
                        description:
                            'The ultimate membership elevates users to "Client" status, providing a personalized matchmaking experience with a dedicated matchmaker.',
                      ),
                      const PlanFeatureItem(text: 'Dedicated Matchmaker'),
                      const PlanFeatureItem(text: 'One-hour onboarding call'),
                      const PlanFeatureItem(
                        text:
                            'Personalized date planning using the GoodLov algorithm',
                      ),
                      const PlanFeatureItem(text: 'Five curated matches'),
                      const PlanFeatureItem(
                        text: 'Video screenings and background checks on dates',
                      ),
                      const PlanFeatureItem(
                        text: 'Two certified relationships coaching sessions',
                      ),
                      const PlanFeatureItem(
                        text:
                            'Ongoing follow-ups with the matchmaker after each other',
                      ),
                      const SizedBox(height: 40),
                      _buildSubscribeButton('\$4,400/Month', '*\$40 annual'),
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

  Widget _buildUltimateIcon() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red[400]!.withAlpha(51),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Ultimate',
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
