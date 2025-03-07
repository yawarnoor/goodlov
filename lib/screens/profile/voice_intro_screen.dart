import 'package:flutter/material.dart';
import 'dart:math';

class VoiceIntroScreen extends StatefulWidget {
  const VoiceIntroScreen({super.key});

  @override
  State<VoiceIntroScreen> createState() => _VoiceIntroScreenState();
}

class _VoiceIntroScreenState extends State<VoiceIntroScreen> {
  bool isRecording = false;

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
                        'Voice intro',
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

              const Spacer(flex: 1),

              // Title and Description
              const Text(
                'Make an great impression\nwith a voice note',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Introduce yourself! Talk about what your\nlife story or just tell a funny story to make\nyour matches laugh....',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),

              const Spacer(flex: 1),

              // Waveform Visualization (placeholder)
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomPaint(
                  painter: WaveformPainter(),
                  size: const Size(double.infinity, 100),
                ),
              ),

              const Spacer(flex: 1),

              // Recording Status
              Text(
                isRecording ? 'Recording...' : 'Tap to start recording',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 24),

              // Record Button
              GestureDetector(
                onTapDown: (_) => setState(() => isRecording = true),
                onTapUp: (_) => setState(() => isRecording = false),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFF5CECC6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black87,
                    size: 32,
                  ),
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class WaveformPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF5CECC6)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const numberOfBars = 50;
    final barWidth = size.width / numberOfBars;
    final random = Random();

    for (var i = 0; i < numberOfBars; i++) {
      final x = i * barWidth;
      final height = random.nextDouble() * size.height;
      final startY = size.height / 2 - height / 2;
      final endY = startY + height;

      canvas.drawLine(
        Offset(x, startY),
        Offset(x, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
