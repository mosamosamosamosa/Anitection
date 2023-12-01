import 'package:flutter/material.dart';
import 'dart:math' as math;

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
          final x2 =
              start.dx + dx / dashCount * ((i + 1) + dashWidth / distance);
          final y2 =
              start.dy + dy / dashCount * ((i + 1) + dashWidth / distance);
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