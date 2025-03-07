import 'package:flutter/material.dart';
import 'package:goodlov/widgets/update_screen_layout.dart';

class UpdateLocationScreen extends StatefulWidget {
  final String? currentLocation;

  const UpdateLocationScreen({
    super.key,
    this.currentLocation,
  });

  @override
  State<UpdateLocationScreen> createState() => _UpdateLocationScreenState();
}

class _UpdateLocationScreenState extends State<UpdateLocationScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentLocation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UpdateScreenLayout(
      title: 'Location',
      helperText:
          'Enter your location and you can only update your name once every 2 months.',
      onUpdate: () {
        // Handle location update
        Navigator.pop(context, _controller.text);
      },
      child: TextField(
        controller: _controller,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: 'Enter location',
          hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withAlpha(76)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF5CECC6)),
          ),
        ),
      ),
    );
  }
}
