
import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/normal_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/components/triangle_line_painter.dart';
import 'package:anitection/components/triangle_painter.dart';
import 'package:anitection/screens/signin/signin_screen.dart';
import 'package:anitection/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitialStartupScreen extends StatefulWidget {
  const InitialStartupScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return InitialStartupScreenState();
  }
}

class InitialStartupScreenState extends State<InitialStartupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E0),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          color: const Color(0xFFC3EB89),
        ),
      ),
      body: Stack(
        children: [
          const AnimalPadBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.width * 0.10512820512 + 10),
                    painter: TrianglePainter(),
                  ),
                  Positioned(
                    child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.width * 0.10512820512),
                      painter: TriangleLinePainter(),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  StrokeText(
                    text: "Animal Protection",
                    strokeColor: Colors.white,
                    strokeWidth: 4,
                    textStyle: GoogleFonts.zenMaruGothic(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF573F1B),
                    ),
                    shadows: const [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  Image.asset("assets/images/anitection_dummy_logo.png"),
                ],
              ),

              Column(
                children: [
                  NormalButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpScreen()),
                      );
                    },
                    width: 316,
                    height: 64,
                    maxElevation: 8,
                    surfaceColor: const Color(0xFFA9DDFF),
                    sideColor: const Color(0xFF61C4DA),
                    child: const StrokeText(
                      text: "アカウント作成",
                      textColor: Color(0xFF573F1B),
                      strokeColor: Colors.white,
                      strokeWidth: 2,
                      shadows: [
                        Shadow(
                          color: Color(0xFF573F1B),
                          offset: Offset(2, 2),
                          blurRadius: 10,
                        ),
                      ],
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  NormalButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInScreen()),
                      );
                    },
                    width: 316,
                    height: 64,
                    maxElevation: 8,
                    surfaceColor: const Color(0xFFFF8C73),
                    sideColor: const Color(0xFFE1765D),
                    child: const StrokeText(
                      text: "ログイン",
                      textColor: Color(0xFF573F1B),
                      strokeColor: Colors.white,
                      strokeWidth: 2,
                      shadows: [
                        Shadow(
                          color: Color(0xFF573F1B),
                          offset: Offset(2, 2),
                          blurRadius: 10,
                        ),
                      ],
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: const Color(0xFFC3EB89),
                    height: 48,
                  ),
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width,
                        40),
                    painter: LinearLinePainter(),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class LinearLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dotLinePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    const dashWidth = 8.0;
    const dashSpace = 8.0;

    // 点線を描画
    for (double i = 0; i < size.width; i += dashWidth + dashSpace) {
      canvas.drawLine(Offset(i, 0), Offset(i + dashWidth, 0), dotLinePaint);
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
