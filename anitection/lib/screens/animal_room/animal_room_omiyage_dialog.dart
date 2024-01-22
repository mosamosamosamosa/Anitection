import 'package:anitection/components/normal_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimalRoomOmiyageDialog extends StatelessWidget {
  const AnimalRoomOmiyageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFFFDB1D), width: 2),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              StrokeText(
                text: "まぐろのお刺身",
                strokeWidth: 2,
                strokeColor: Colors.white,
                textColor: const Color(0xFF573F1B),
                shadows: [
                  const Shadow(
                    color: Colors.black,
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  )
                ],
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Stack(
                children: [
                  Image.asset(
                    "assets/images/img_maguro.png",
                    width: 115,
                    height: 69,
                  ),
                  Lottie.asset("assets/lottie/kirakira.json", width: 132, height: 100),
                ],
              ),
              NormalButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                surfaceColor: const Color(0xFFFFDB1D),
                sideColor: const Color(0xFFFFB001),
                width: 200,
                height: 60,
                child: StrokeText(
                  text: "受け取る",
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                  textColor: const Color(0xFF573F1B),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  shadows: [
                    const Shadow(
                      color: Colors.black,
                      offset: Offset(0, 0),
                      blurRadius: 10,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
