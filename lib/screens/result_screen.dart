import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:goodlov/models/user.dart';
import 'dart:math' show sin, cos, pi;
import 'package:goodlov/navigation/main_navigation.dart'; // Fixed import path

class ResultsScreen extends StatelessWidget {
  final User user;

  const ResultsScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    // Get traits and identify the highest and second highest
    final traits = user.personalityTraits.entries.toList();
    traits.sort((a, b) => b.value.compareTo(a.value));
    final dominantTrait = traits.isNotEmpty ? traits[0].key : '';
    final secondaryTrait = traits.length > 1 ? traits[1].key : '';

    // Resort traits to original order for radar chart
    final originalOrder = user.personalityTraits.keys.toList();
    traits.sort((a, b) =>
        originalOrder.indexOf(a.key).compareTo(originalOrder.indexOf(b.key)));

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button and progress
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '8 to 20',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Progress dots
              Container(
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(
                    8,
                    (index) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        color: const Color(0xFF5CECC6),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Personality and\nComparability Insights',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Here is how your personality traits align with our key comparability categories.',
                      style: TextStyle(
                        color: Colors.white.withAlpha(204),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(user.profileImage!),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Radar Chart with overlay dots
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Stack(
                    children: [
                      // Base Radar Chart
                      RadarChart(
                        RadarChartData(
                          radarShape: RadarShape.polygon,
                          ticksTextStyle:
                              const TextStyle(color: Colors.transparent),
                          gridBorderData:
                              const BorderSide(color: Colors.white24, width: 1),
                          tickBorderData:
                              const BorderSide(color: Colors.transparent),
                          radarBorderData:
                              const BorderSide(color: Colors.white24, width: 1),
                          titleTextStyle: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          getTitle: (index, _) =>
                              RadarChartTitle(text: traits[index].key),
                          dataSets: [
                            RadarDataSet(
                              fillColor: const Color(0xFFFF6B6B).withAlpha(77),
                              borderColor: const Color(0xFFFF6B6B),
                              entryRadius: 0, // Hide default dots
                              dataEntries: traits
                                  .map((e) => RadarEntry(value: e.value))
                                  .toList(),
                            ),
                          ],
                          titlePositionPercentageOffset: 0.2,
                        ),
                      ),

                      // Overlay for colored dots
                      // Using LayoutBuilder to get the exact size of the chart container
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final double centerX = constraints.maxWidth / 2;
                          final double centerY = constraints.maxHeight / 2;
                          // Use 80% of the minimum dimension to approximate radar chart radius
                          final double radius =
                              (constraints.maxWidth < constraints.maxHeight
                                      ? constraints.maxWidth
                                      : constraints.maxHeight) *
                                  0.4;

                          return Stack(
                            children: traits.asMap().entries.map((entry) {
                              final int index = entry.key;
                              final String trait = entry.value.key;
                              final double value = entry.value.value;

                              // Only add dots for dominant and secondary traits
                              if (trait != dominantTrait &&
                                  trait != secondaryTrait) {
                                return const SizedBox.shrink();
                              }

                              // Calculate the position for the dot
                              // Start at top (270 degrees/-90 degrees) and go clockwise
                              final double angle =
                                  (2 * pi * index / traits.length) - (pi / 2);
                              final double x =
                                  centerX + (radius * value * cos(angle));
                              final double y =
                                  centerY + (radius * value * sin(angle));

                              final Color dotColor = trait == dominantTrait
                                  ? const Color(
                                      0xFFFF6B6B) // Orange for dominant
                                  : Colors.purple; // Purple for secondary

                              return Positioned(
                                left: x - 6, // Adjust for dot size
                                top: y - 6, // Adjust for dot size
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: dotColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Legend
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFF6B6B),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Dominant Trait',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 24),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Secondary Trait',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              // View Matches Button
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MainNavigation(initialTab: 0),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5CECC6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'View Matches',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
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
}
