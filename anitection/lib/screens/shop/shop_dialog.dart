import 'package:anitection/components/normal_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ShopDialog extends StatelessWidget {
  ShopDialog({super.key, required this.name, required this.image});

  String name;
  String image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 260,
        width: 290,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFFFDB1D), width: 3),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              StrokeText(
                text: name,
                strokeWidth: 6,
                strokeColor: Colors.white,
                textColor: const Color(0xFF573F1B),
                shadows: [
                  const Shadow(
                    color: Color.fromARGB(255, 129, 108, 108),
                    offset: Offset(0, 4),
                    blurRadius: 10,
                  )
                ],
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Image.asset(
                "assets/images/$image",
                width: 115,
                height: 69,
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NormalButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    surfaceColor: const Color(0xFFC9C9C9),
                    sideColor: const Color(0xFFA2A2A2),
                    width: 120,
                    height: 54,
                    child: StrokeText(
                      text: "キャンセル",
                      strokeWidth: 4,
                      strokeColor: Colors.white,
                      textColor: const Color(0xFF573F1B),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      shadows: [
                        const Shadow(
                          color: Colors.black,
                          offset: Offset(0, 3),
                          blurRadius: 10,
                        )
                      ],
                    ),
                  ),
                  NormalButton(
                    onPressed: () {
                      //購入
                    },
                    surfaceColor: const Color(0xFFFFDB1D),
                    sideColor: const Color(0xFFFFB001),
                    width: 120,
                    height: 54,
                    child: StrokeText(
                      text: "購入",
                      strokeWidth: 4,
                      strokeColor: Colors.white,
                      textColor: const Color(0xFF573F1B),
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      shadows: [
                        const Shadow(
                          color: Colors.black,
                          offset: Offset(0, 3),
                          blurRadius: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
