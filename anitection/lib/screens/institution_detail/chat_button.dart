import 'package:anitection/components/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatButton extends StatelessWidget {
  const ChatButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
            bottom: -8,
            child: Container(
              width: 90,
              height: 90,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD9D9D9),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            )),
        Container(
          width: 90,
          height: 90,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFFFDF90),
            border: Border.all(
              color: Colors.white,
              width: 4,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 10,
                child: SvgPicture.asset(
                  "assets/svg/ic_chat_and_shadow.svg",
                  width: 40,
                  height: 32,
                ),
              ),
              const Positioned(
                top: 32,
                child: StrokeText(
                  text: "チャット",
                  textColor: Color(0xFFC39248),
                  strokeColor: Colors.white,
                  strokeWidth: 2,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
