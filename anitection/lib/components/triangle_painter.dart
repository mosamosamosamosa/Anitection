import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFC3EB89)
      ..style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(size.width / 2, size.height); // 上の中心点
    path.lineTo(size.width, 10); // 右下の点
    path.lineTo(0, 10); // 左下の点
    path.close(); // パスを閉じる

    // 影を描画
    canvas.drawShadow(path, Colors.black.withOpacity(0.5), 4.0, false);

    // 0,0からsize.width, 10まで四角形を描画
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, 10), paint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
