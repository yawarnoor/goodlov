import 'package:flutter/material.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  int selectedHeight = 150; // Default selected height in cm

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
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        'Height',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40), // Balance for back button
                  ],
                ),
              ),

              // Height List
              Expanded(
                child: ListView.builder(
                  itemCount: 51, // 122cm to 172cm
                  itemBuilder: (context, index) {
                    final height = 122 + index;
                    final feet = (height / 30.48).floor();
                    final inches = ((height / 2.54) % 12).round();

                    return ListTile(
                      onTap: () => setState(() => selectedHeight = height),
                      title: Row(
                        children: [
                          Text(
                            '${height}cm',
                            style: TextStyle(
                              color: height == selectedHeight
                                  ? const Color(0xFF5CECC6)
                                  : Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            ' . ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '$feet\'$inches"',
                            style: TextStyle(
                              color: height == selectedHeight
                                  ? const Color(0xFF5CECC6)
                                  : Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      trailing: height == selectedHeight
                          ? const Icon(
                              Icons.check_circle,
                              color: Color(0xFF5CECC6),
                            )
                          : null,
                    );
                  },
                ),
              ),

              // Update Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle height update
                      Navigator.pop(context, selectedHeight);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5CECC6),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
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
