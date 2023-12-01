import 'package:anitection/components/animal_pad_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import math
import 'dart:math' as math;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            color: Color(0xFFC3EB89),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        width: 24,
                        height: 18,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/ic_calendar.svg",
                          width: 50,
                          height: 50,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFF94CD68),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          child: const Text(
                            "10月30日",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/ic_setting.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: Stack(
        children: [
          const AnimalPadBackground(),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 8,
                color: const Color(0xFFC3EB89),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.width * 0.10512820512),
                  painter: TrianglePainter(),
                ),
                Positioned(child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.width * 0.10512820512),
                  painter: TriangleLinePainter(),
                ), top: -10,)
              ],),
            ],
          )
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xFFC3EB89)
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(size.width / 2, size.height); // 上の中心点
    path.lineTo(size.width, 0); // 右下の点
    path.lineTo(0, 0); // 左下の点
    path.close(); // パスを閉じる

    // 影のスタイルを定義
    // var shadowPaint = Paint()
    //   ..color = Colors.black.withOpacity(0.1) // 影の色と透明度
    //   ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10); // ぼかしのスタイルと度合い

    // 影を描画
    canvas.drawShadow(path, Colors.black.withOpacity(0.5), 4.0, false);

    canvas.drawPath(path, paint);

    // 点線を描画
    // var dotPathPaint = Paint()
    //   ..color = Colors.white
    //   ..strokeWidth = 4;
    //
    // double dashWidth = 5.0, dashSpace = 6.0, startX = 0.0;
    // while (startX < size.width) {
    //   canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), dotPathPaint);
    //   startX += dashWidth + dashSpace;
    // }
    //
    // final paint = Paint()
    //   ..color = Colors.black
    //   ..strokeWidth = 1;


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TriangleLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dotLinePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    const dashWidth = 5.0;
    const dashSpace = 3.0;
    void drawDashedLine(Offset start, Offset end) {
      final dx = end.dx - start.dx;
      final dy = end.dy - start.dy;
      final distance = math.sqrt(dx * dx + dy * dy);
      final dashCount = (distance / (dashWidth + dashSpace)).floor();

      for (var i = 0; i < dashCount; ++i) {
        if (i % 2 == 0) {
          final x1 = start.dx + dx / dashCount * (i + dashWidth / distance);
          final y1 = start.dy + dy / dashCount * (i + dashWidth / distance);
          final x2 = start.dx + dx / dashCount * ((i + 1) + dashWidth / distance);
          final y2 = start.dy + dy / dashCount * ((i + 1) + dashWidth / distance);
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dotLinePaint);
        }
      }
    }

    // 三角形の頂点を計算
    final point1 = Offset(size.width / 2, size.height);
    final point2 = Offset(0, 0);
    final point3 = Offset(size.width, 0);

    // 各辺に点線を描画
    drawDashedLine(point1, point2);
    drawDashedLine(point3, point1);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}
