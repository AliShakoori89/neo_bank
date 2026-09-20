import 'dart:async';

import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;

  const TypewriterText({
    super.key,
    required this.text,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String displayedText = '';
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    Timer.periodic(
      const Duration(milliseconds: 100),
          (timer) {
        if (currentIndex < widget.text.length) {
          setState(() {
            displayedText += widget.text[currentIndex];
            currentIndex++;
          });
        } else {
          timer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(displayedText);
  }
}