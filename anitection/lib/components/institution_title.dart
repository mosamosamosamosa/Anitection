
import 'package:anitection/components/stroke_text.dart';
import 'package:flutter/material.dart';

class InstitutionTitle extends StatelessWidget {
  const InstitutionTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return StrokeText(
      text: title,
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      strokeWidth: 4,
      strokeColor: Colors.white,
      textColor: const Color(0xFF573F1B),
      shadows: const [
        Shadow(
          blurRadius: 10,
          color: Colors.black,
          offset: Offset(2, 2),
        ),
      ],
    );
  }
}