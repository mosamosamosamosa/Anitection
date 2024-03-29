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
    required this.isCleanMode,
    required this.onCleanComplete,
    required this.selectedToyType,
    this.onAnimalMovedListener,
    required this.isCat,
    required this.id,
  });

  final Size size;
  final VoidCallback onAvatarTap;
  final VoidCallback onCleanComplete;
  final Size avatarSize;
  final String avatarImageUrl;
  final String avatarHeadImageUrl;
  final String avatarBodyImageUrl;
  final String avatarTailImageUrl;
  final bool isCleanMode;
  final ToyType? selectedToyType;
  final OnAnimalMovedListener? onAnimalMovedListener;
  final bool isCat;
  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AnimalAvatarAreaState();
  }
}

class AnimalAvatarAreaState extends ConsumerState<AnimalAvatarArea> {
  final Point _position = Point(0, 0);
  final Point _dustClothPosition = Point(0, 0);
  final avatarWidth = 250.0;
  late double avatarHeight;

  DateTime? cleanStartTime;
  Offset? lastTapDownPosition;

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
    widget.onAnimalMovedListener?.call(Offset(_position.x, _position.y));
  }

  void renderToy(Offset position) async {
  }

  void updateRandomSpeechBubbleState() {
    // 確率計算
    final random = math.Random();
    // 1/10の確率でSpeechStateType.needClean
    final n = random.nextInt(25);
    if (n == 0) {
      ref.read(speechStateProvider.notifier).state = SpeechStateType.needClean;
    } else if (n == 1) {
      ref.read(speechStateProvider.notifier).state = SpeechStateType.needFood;
    } else {
      ref.read(speechStateProvider.notifier).state = SpeechStateType.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    final faceState = ref.watch(faceStateProvider(widget.id));
    return GestureDetector(
      onTapDown: (details) {
        log("onTapDown, x: ${details.localPosition.dx}, y: ${details.localPosition.dy}");

        setState(() {
          lastTapDownPosition = details.localPosition;
        });
        if (widget.selectedToyType != null) {
          renderToy(details.localPosition);
        }
        if (!widget.isCleanMode) {
          moveToPosition(details.localPosition);
        }
        // moveToPosition(details.localPosition);
      },
      onPanUpdate: (details) {
        log("onPanUpdate, x: ${details.localPosition.dx}, y: ${details.localPosition.dy}");
        if (widget.isCleanMode) {
          setState(() {
            _dustClothPosition.x = details.localPosition.dx;
            _dustClothPosition.y = details.localPosition.dy;
          });
          final cleanEndTime = DateTime.now();
          final cleanDuration = cleanEndTime.difference(cleanStartTime!);
          log("cleanDuration: ${cleanDuration.inSeconds}");
          if (cleanDuration.inSeconds == 2) {
            widget.onCleanComplete();
            cleanStartTime = null;
          }
        }
      },
      onPanStart: (details) {
        log("onPanStart, x: ${details.localPosition.dx}, y: ${details.localPosition.dy}");
        if (widget.isCleanMode) {
          cleanStartTime = DateTime.now();
        }
      },
      onPanEnd: (details) {
        cleanStartTime = null;
      },
      onPanCancel: () {
        cleanStartTime = null;
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
                  effectType: ref.watch(effectStateProvider(widget.id)),
                  foodType: ref.watch(selectedFoodProvider(widget.id)),
                  speechState: ref.watch(speechStateProvider),
                  isCat: widget.isCat,
                ),
              ),
            ),
            if (widget.isCleanMode)
              Positioned(
                top: (_dustClothPosition.y - avatarHeight / 2) + 100,
                left: _dustClothPosition.x - avatarWidth / 2,
                child: GestureDetector(
                  onTap: widget.onAvatarTap,
                  child: Transform.rotate(
                    angle: 10,
                    child: Image.asset(
                      "assets/images/img_dust_cloth.png",
                      width: 78,
                      height: 58,
                    ),
                  ),
                ),
              ),
            if (widget.selectedToyType != null && lastTapDownPosition != null)
              Positioned(
                top: (lastTapDownPosition!.dy - avatarHeight / 2) + 100,
                left: lastTapDownPosition!.dx - avatarWidth / 2,
                child: ToyRender(selectedToyType: widget.selectedToyType),
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
    required this.isCat,
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
  final bool isCat;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: avatarWidth,
      height: avatarHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -(avatarHeight * 0.039),
            left: avatarWidth * 0.35,
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
            left: (avatarWidth * 0.124),
            child: Lottie.asset(
              'assets/lottie/${() {
                if (isCat) {
                  switch (faceState) {
                    case FaceStateType.blink:
                      return 'blink_cat1';
                    case FaceStateType.sad:
                      return 'sad_cat';
                    case FaceStateType.smile:
                      return 'smile_cat';
                    case FaceStateType.sleeping:
                      return 'sleep_cat';
                  }
                } else {
                  switch (faceState) {
                    case FaceStateType.blink:
                      return 'blink_dog';
                    case FaceStateType.sad:
                      return 'sad_dog';
                    case FaceStateType.smile:
                      return 'smile_dog';
                    case FaceStateType.sleeping:
                      return 'sleep_dog';
                  }
                }
              }()}.json',
              width: avatarWidth * 0.85,
              height: avatarHeight * 0.85,
              fit: BoxFit.cover,
            ),
          ),
          if (faceState == FaceStateType.sleeping)
            Positioned(
              top: -(avatarHeight * 0.3),
              left: -(avatarWidth * 0.25),
              child: Lottie.asset(
                'assets/lottie/zzz.json',
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
                )),
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
  const SpeechBubble(
      {super.key,
      required this.avatarHeight,
      required this.avatarWidth,
      required this.speechState,
      });

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
              switch (speechState) {
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

class ToyRender extends StatelessWidget {
  const ToyRender({super.key, required this.selectedToyType});
  final ToyType? selectedToyType;

  @override
  Widget build(BuildContext context) {
    switch (selectedToyType) {
      case ToyType.nekojarashi:
        return SvgPicture.asset(
          "assets/svg/img_nekojarashi.svg",
          width: 78,
          height: 58,
        );
      case ToyType.ball:
        return SvgPicture.asset(
          "assets/svg/img_ball.svg",
          width: 78,
          height: 58,
        );
      case ToyType.fish:
        return SvgPicture.asset(
          "assets/svg/img_fish.svg",
          width: 78,
          height: 58,
        );
      default:
        return Container();
    }
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

typedef OnAnimalMovedListener = void Function(Offset position);

enum FaceStateType {
  blink,
  sad,
  smile,
  sleeping,
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

enum ToyType {
  nekojarashi,
  ball,
  fish,
}

final faceStateProvider = StateProvider.family((ref, int id) => FaceStateType.blink);
final effectStateProvider = StateProvider.family((ref, int id) => EffectType.none);
final selectedFoodProvider = StateProvider.family((ref, int id) => FoodType.none);
final speechStateProvider =
    StateProvider((ref) => SpeechStateType.none);
final toyStateProvider = StateProvider.autoDispose((ref) => ToyType.nekojarashi);
