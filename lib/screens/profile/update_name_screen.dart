import 'package:flutter/material.dart';
import 'package:goodlov/widgets/update_screen_layout.dart';

class UpdateNameScreen extends StatefulWidget {
  final String currentName;

  const UpdateNameScreen({
    super.key,
    required this.currentName,
  });

  @override
  State<UpdateNameScreen> createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends State<UpdateNameScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UpdateScreenLayout(
      title: 'First Name',
      helperText:
          'Enter your name and you can only update your name once every 2 months.',
      onUpdate: () {
        // Handle name update
        Navigator.pop(context, _controller.text);
      },
      child: Stack(
        children: [
          TextField(
            controller: _controller,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Enter name',
              hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withAlpha(76)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF5CECC6)),
              ),
            ),
          ),
          if (_controller.text.isNotEmpty)
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _controller.clear();
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
