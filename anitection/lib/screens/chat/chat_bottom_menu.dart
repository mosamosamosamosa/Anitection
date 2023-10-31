
import 'package:anitection/components/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatBottomMenu extends StatelessWidget {
  const ChatBottomMenu({
    super.key,
    required this.onMenuPressed,
    required this.onKeyboardPressed,
  });

  final VoidCallback onMenuPressed;
  final VoidCallback onKeyboardPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -2),
            blurRadius: 4,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onKeyboardPressed,
            child: SvgPicture.asset(
              "assets/svg/ic_orange_keyboard.svg",
              width: 32,
              height: 32,
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: GestureDetector(
                onTap: onMenuPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const StrokeText(
                      text: "メニュー",
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      strokeWidth: 4,
                      strokeColor: Colors.white,
                      textColor: Color(0xFF573F1B),
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    const SizedBox(width: 2),
                    CustomPaint(
                      painter: TrianglePainter(),
                      size: const Size(12, 12),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    var paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;

    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);

    var borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}