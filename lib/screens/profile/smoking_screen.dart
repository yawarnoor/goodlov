import 'package:flutter/material.dart';

class SmokingScreen extends StatefulWidget {
  const SmokingScreen({super.key});

  @override
  State<SmokingScreen> createState() => _SmokingScreenState();
}

class _SmokingScreenState extends State<SmokingScreen> {
  bool isSmoker = false;

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
                        'Smoking',
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

              // Options
              ListTile(
                onTap: () => setState(() => isSmoker = true),
                title: Text(
                  'Smoker',
                  style: TextStyle(
                    color: isSmoker ? const Color(0xFF5CECC6) : Colors.white,
                    fontSize: 16,
                  ),
                ),
                trailing: isSmoker
                    ? const Icon(
                        Icons.check_circle,
                        color: Color(0xFF5CECC6),
                      )
                    : null,
              ),
              ListTile(
                onTap: () => setState(() => isSmoker = false),
                title: Text(
                  'Non-smoker',
                  style: TextStyle(
                    color: !isSmoker ? const Color(0xFF5CECC6) : Colors.white,
                    fontSize: 16,
                  ),
                ),
                trailing: !isSmoker
                    ? const Icon(
                        Icons.check_circle,
                        color: Color(0xFF5CECC6),
                      )
                    : null,
              ),

              const Spacer(),

              // Update Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle smoking preference update
                      Navigator.pop(context, isSmoker);
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
