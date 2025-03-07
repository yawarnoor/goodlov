import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int minAge = 18;
  int maxAge = 90;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Filters',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Reset all filters to default
              setState(() {
                minAge = 18;
                maxAge = 90;
              });
            },
            child: const Text(
              'Clear all',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Basic information',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const Text(
                          'Age',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        _buildAgeSelector(
                          label: 'From:',
                          value: minAge,
                          onDecrease: () {
                            if (minAge > 18) {
                              setState(() => minAge--);
                            }
                          },
                          onIncrease: () {
                            if (minAge < maxAge) {
                              setState(() => minAge++);
                            }
                          },
                        ),
                        const SizedBox(width: 16),
                        _buildAgeSelector(
                          label: 'To:',
                          value: maxAge,
                          onDecrease: () {
                            if (maxAge > minAge) {
                              setState(() => maxAge--);
                            }
                          },
                          onIncrease: () {
                            if (maxAge < 90) {
                              setState(() => maxAge++);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildFilterOption(
                      title: 'Height',
                      subtitle: 'No preference',
                      onTap: () {
                        // Navigate to height selection
                      },
                    ),
                    _buildFilterOption(
                      title: 'Location',
                      subtitle: 'United Kingdom',
                      onTap: () {
                        // Navigate to location selection
                      },
                    ),
                    _buildFilterOption(
                      title: 'Marital status',
                      subtitle: 'No preference',
                      onTap: () {
                        // Navigate to marital status selection
                      },
                    ),
                    _buildFilterOption(
                      title: 'Children',
                      subtitle: 'No preference',
                      onTap: () {
                        // Navigate to children preference selection
                      },
                    ),
                    _buildFilterOption(
                      title: 'Grew up in',
                      subtitle: 'No preference',
                      onTap: () {
                        // Navigate to grew up in selection
                      },
                    ),
                    _buildFilterOption(
                      title: 'Marriage plans',
                      subtitle: 'No preference',
                      onTap: () {
                        // Navigate to marriage plans selection
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Apply filters and close screen
                  Navigator.pop(context, {
                    'minAge': minAge,
                    'maxAge': maxAge,
                    // Add other filter values here
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5CECC6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  'Apply',
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
    );
  }

  Widget _buildAgeSelector({
    required String label,
    required int value,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(width: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFFF4D67),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              _buildAgeButton(
                icon: Icons.remove,
                onPressed: onDecrease,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 30),
                child: Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _buildAgeButton(
                icon: Icons.add,
                onPressed: onIncrease,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAgeButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            icon,
            size: 16,
            color: const Color(0xFFFF4D67),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterOption({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
