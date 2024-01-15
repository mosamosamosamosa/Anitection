import 'dart:developer';

// math import
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final avatarWidth = 250.0;
  late double avatarHeight;

  int animationSession = DateTime.now().microsecondsSinceEpoch;

  @override
  void initState() {
    avatarHeight =
        (widget.avatarSize.height / widget.avatarSize.width * avatarWidth);
    setState(() {
      _position.x = widget.size.width / 2;
      _position.y = widget.size.height / 6;
    });
    super.initState();
  }

  void moveToPosition(Offset position) async {
    updateRandomSpeechBubbleState();
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

  void updateRandomSpeechBubbleState() {
    // 確率計算
    final random = math.Random();
    // 1/10の確率でSpeechStateType.needClean
    final n = random.nextInt(25);
    if (n == 0) {
      ref.read(speechStateProvider.notifier).state = SpeechStateType.needClean;
    } else if (n == 1){
      ref.read(speechStateProvider.notifier).state = SpeechStateType.needFood;
    } else {
      ref.read(speechStateProvider.notifier).state = SpeechStateType.none;
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
                  foodType: ref.watch(selectedFoodProvider),
                  speechState: ref.watch(speechStateProvider),
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
    required this.foodType,
    required this.speechState,
  });

  final double avatarWidth;
  final double avatarHeight;
  final String avatarTailImageUrl;
  final String avatarBodyImageUrl;
  final String avatarHeadImageUrl;
  final FaceStateType faceState;
  final EffectType effectType;
  final FoodType foodType;
  final SpeechStateType speechState;

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
            top: -(avatarHeight * 0.057),
            left: (avatarWidth * 0.115),
            child: Lottie.asset(
              'assets/lottie/${() {
                switch (faceState) {
                  case FaceStateType.blink:
                    return 'blink_cat1';
                  case FaceStateType.sad:
                    return 'sad_cat';
                  case FaceStateType.smile:
                    return 'smile_cat';
                }
              }()}.json',
              width: avatarWidth * 0.85,
              height: avatarHeight * 0.85,
              fit: BoxFit.cover,
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
          if (foodType != FoodType.none)
            Positioned(
              top: avatarHeight * 0.5,
              left: avatarWidth * 0.28,
              child: FoodRender(foodType),
            ),
          if (speechState != SpeechStateType.none)
            Positioned(
                top: -(avatarHeight * 0.45),
                left: (avatarWidth * 0.23),
                child: SpeechBubble(
                  avatarHeight: avatarHeight,
                  avatarWidth: avatarWidth,
                  speechState: speechState,
                )
            ),
        ],
      ),
    );
  }
}

class FoodRender extends StatelessWidget {
  final FoodType foodType;

  const FoodRender(this.foodType, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (foodType) {
      case FoodType.karikari:
        return Image.asset('assets/images/img_karikari.png', width: 40);
      case FoodType.maguro:
        return Image.asset('assets/images/img_maguro.png', width: 40);
      case FoodType.nekocan:
        return Image.asset('assets/images/img_nekocan.png', width: 40);
      case FoodType.none:
        return Container();
    }
  }
}

class SpeechBubble extends StatelessWidget {
  const SpeechBubble({super.key, required this.avatarHeight, required this.avatarWidth, required this.speechState});
  final double avatarHeight;
  final double avatarWidth;
  final SpeechStateType speechState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: avatarHeight * 0.5,
      width: avatarHeight * 0.5 * 0.83333333333,
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/svg/ic_speech_background.svg',
            fit: BoxFit.cover,
          ),
          Container(
            width: avatarHeight * 0.5 * 0.83333333333,
            height: avatarHeight * 0.5 * 0.83333333333,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: (avatarHeight * 0.1)),
            child: () {
              switch(speechState) {
                case SpeechStateType.none:
                  return Container();
                case SpeechStateType.needClean:
                  return SvgPicture.asset(
                    'assets/svg/ic_speech_need_clean.svg',
                    fit: BoxFit.cover,
                  );
                case SpeechStateType.needFood:
                  return SvgPicture.asset(
                    'assets/svg/ic_speech_need_food.svg',
                    fit: BoxFit.cover,
                  );
                case SpeechStateType.present4You:
                  return SvgPicture.asset(
                    'assets/svg/ic_speech_present_4_you.svg',
                    fit: BoxFit.cover,
                  );
              }
            }(),
          )
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
  blink,
  sad,
  smile,
}

enum EffectType {
  none,
  kirakira,
}

enum FoodType {
  karikari,
  maguro,
  nekocan,
  none,
}

enum SpeechStateType {
  none,
  needClean,
  needFood,
  present4You,
}

final faceStateProvider = StateProvider((ref) => FaceStateType.blink);
final effectStateProvider = StateProvider((ref) => EffectType.none);
final selectedFoodProvider = StateProvider((ref) => FoodType.none);
final speechStateProvider = StateProvider.autoDispose((ref) => SpeechStateType.none);
