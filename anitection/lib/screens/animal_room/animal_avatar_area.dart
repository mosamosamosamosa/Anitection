

import 'dart:developer';

import 'package:flutter/cupertino.dart';
// math import
import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimalAvatarArea extends StatefulWidget {
  const AnimalAvatarArea({super.key, required this.size});
  final Size size;

  @override
  State<StatefulWidget> createState() {
    return AnimalAvatarAreaState();
  }
}

class AnimalAvatarAreaState extends State<AnimalAvatarArea> {
  final Point _position = Point(0, 0);
  final avatarWidth = 171.0;
  final avatarHeight = 191.0;

  int animationSession = DateTime.now().microsecondsSinceEpoch;
  void moveToPosition(Offset position) async {
    const double tolerance = 10.0; // 許容される誤差の範囲
    final current = DateTime.now().microsecondsSinceEpoch;
    animationSession = current;
    while(((_position.x - position.dx).abs() > tolerance ||
        (_position.y - position.dy).abs() > tolerance) &&
            animationSession == current) {
      setState(() {
        _position.moveTowards(Point(position.dx, position.dy), 5);
      });
      await Future.delayed(const Duration(milliseconds: 10));
    }

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        log("onTapDown, x: ${details.localPosition.dx}, y: ${details.localPosition.dy}");

        moveToPosition(details.localPosition);

        // moveToPosition(details.localPosition);
      },
      child: Container(
        width: widget.size.width,
        height: widget.size.height,
        color: Colors.transparent,
        padding: const EdgeInsets.all(0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: _position.y - avatarHeight / 2,
              left: _position.x - avatarWidth / 2,
              child: Image.asset("assets/images/img_example_dog.png", width: 171, height: 191,),
            ),
          ],
        )
      ),
    );
  }
}

class Point {
  double x, y;

  Point(this.x, this.y);

  /// Move this point towards another point [target] by [speed].
  void moveTowards(Point target, double speed) {
    double dx = target.x - x;
    double dy = target.y - y;

    double length = math.sqrt(dx * dx + dy * dy);

    // To avoid division by zero
    if (length == 0) return;

    dx /= length;
    dy /= length;

    x += dx * speed;
    y += dy * speed;
  }
}