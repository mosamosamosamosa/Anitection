
import 'package:anitection/components/stroke_text.dart';
import 'package:flutter/material.dart';

class AnimalNameLabel extends StatelessWidget {
  const AnimalNameLabel({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return StrokeText(
      text: name,
      strokeColor: Colors.white,
      textColor: const Color(0xFF573F1B),
      textAlign: TextAlign.center,
      strokeWidth: 4,
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      shadows: const [
        Shadow(
          blurRadius: 10,
          color: Colors.black,
          offset: Offset(2, 2),
        )
      ],
    );
  }
}