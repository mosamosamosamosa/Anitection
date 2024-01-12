import 'dart:developer';

import 'package:flutter/cupertino.dart';

// math import
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class AnimalAvatarArea extends ConsumerStatefulWidget {
  const AnimalAvatarArea({
    super.key,
    required this.size,
    required this.onAvatarTap,
    required this.avatarImageUrl,
    required this.avatarSize,
    required this.avatarHeadImageUrl,
    required this.avatarBodyImageUrl,
    required this.avatarTailImageUrl,
  });

  final Size size;
  final VoidCallback onAvatarTap;
  final Size avatarSize;
  final String avatarImageUrl;
  final String avatarHeadImageUrl;
  final String avatarBodyImageUrl;
  final String avatarTailImageUrl;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AnimalAvatarAreaState();
  }
}

class AnimalAvatarAreaState extends ConsumerState<AnimalAvatarArea> {
  final Point _position = Point(0, 0);
  final avatarWidth = 171.0;
  late double avatarHeight;

  int animationSession = DateTime.now().microsecondsSinceEpoch;

  @override
  void initState() {
    avatarHeight =
        (widget.avatarSize.height / widget.avatarSize.width * avatarWidth);
    super.initState();
  }

  void moveToPosition(Offset position) async {
    const double tolerance = 10.0; // 許容される誤差の範囲
    final current = DateTime.now().microsecondsSinceEpoch;
    animationSession = current;
    while (((_position.x - position.dx).abs() > tolerance ||
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
    final faceState = ref.watch(faceStateProvider);
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
              child: GestureDetector(
                onTap: widget.onAvatarTap,
                child: AnimalView(
                  avatarWidth: avatarWidth,
                  avatarHeight: avatarHeight,
                  avatarTailImageUrl: widget.avatarTailImageUrl,
                  avatarBodyImageUrl: widget.avatarBodyImageUrl,
                  avatarHeadImageUrl: widget.avatarHeadImageUrl,
                  faceState: faceState,
                  effectType: ref.watch(effectStateProvider),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimalView extends StatelessWidget {
  const AnimalView({
    super.key,
    required this.avatarWidth,
    required this.avatarHeight,
    required this.avatarTailImageUrl,
    required this.avatarBodyImageUrl,
    required this.avatarHeadImageUrl,
    required this.faceState,
    required this.effectType,
  });
  final double avatarWidth;
  final double avatarHeight;
  final String avatarTailImageUrl;
  final String avatarBodyImageUrl;
  final String avatarHeadImageUrl;
  final FaceStateType faceState;
  final EffectType effectType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: avatarWidth,
      height: avatarHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: avatarWidth * 0.265,
            child: Image.network(
              avatarTailImageUrl,
              width: avatarWidth,
              height: avatarHeight,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.network(
              avatarBodyImageUrl,
              width: avatarWidth,
              height: avatarHeight,
            ),
          ),

          Positioned(
            top: -(avatarHeight * 0.3),
            left: -(avatarWidth * 0.1),
            child: Image.network(
              avatarHeadImageUrl,
              width: avatarWidth,
              height: avatarHeight,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Lottie.asset(
              'assets/lottie/${() {
                switch(faceState) {
                  case FaceStateType.blink:
                    return 'blink_cat1';
                  case FaceStateType.sad:
                    return 'sad_cat';
                  case FaceStateType.smile:
                    return 'smile_cat';
                }
              }()
              }.json',
              width: avatarWidth,
              height: avatarHeight,
            ),
          ),
          if (effectType == EffectType.kirakira)
            Positioned(
              top: 0,
              left: 0,
              child: Lottie.asset(
                'assets/lottie/kirakira.json',
                width: avatarWidth,
                height: avatarHeight,
              ),
            ),
        ],
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

enum FaceStateType {
  blink, sad, smile,
}

enum EffectType {
  none, kirakira,
}
final faceStateProvider = StateProvider((ref) => FaceStateType.blink);
final effectStateProvider = StateProvider((ref) => EffectType.none);