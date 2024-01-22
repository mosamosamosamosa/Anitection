import 'dart:async';

import 'package:anitection/repositories/clean_history_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CleanBackground extends ConsumerStatefulWidget {
  final Size size;
  final DateTime? lastCleanDateTime;
  final VoidCallback? onRoomDirty;
  final int animalId;

  const CleanBackground(
      {super.key,
      required this.size,
      required this.lastCleanDateTime,
      this.onRoomDirty,
      required this.animalId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return CleanBackgroundState();
  }
}

class CleanBackgroundState extends ConsumerState<CleanBackground> {
  DateTime now = DateTime.now();
  int alpha = 0;
  StreamSubscription? subscription;

  @override
  void initState() {
    // subscription = ref.read(cleanHistoryRepository).getDirtyLevelStream(widget.animalId).listen((event) {
    //   final beforeAlpha = alpha;
    //   if (alpha == 255 && beforeAlpha != 255) {
    //     widget.onRoomDirty?.call();
    //   }
    //   setState(() {
    //     alpha = event;
    //   });
    // });
    Future.microtask(() async {
      while(true) {
        await Future.delayed(const Duration(seconds: 1), () async {
          final beforeAlpha = alpha;
          final newAlpha = await ref.read(cleanHistoryRepository).getDirtyLevel(widget.animalId);
          setState(() {
            now = DateTime.now();
            // alpha = (widget.lastCleanDateTime == null ? 255 : ((now.difference(widget.lastCleanDateTime!).inSeconds / 1).floor())).clamp(0, 255);
            alpha = newAlpha;
          });
          if (alpha == 255 && beforeAlpha != 255) {
            widget.onRoomDirty?.call();
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: widget.size.height * 0.15,
          left: -widget.size.width * 0.05,
          child: SvgPicture.asset(
            "assets/svg/img_trush.svg",
            colorFilter:
                ColorFilter.mode(Colors.grey.withAlpha(alpha), BlendMode.srcIn),
          ),
        ),
        Positioned(
          top: widget.size.height * 0.3,
          right: -widget.size.width * 0.05,
          child: SvgPicture.asset(
            "assets/svg/img_trush.svg",
            colorFilter:
                ColorFilter.mode(Colors.grey.withAlpha(alpha), BlendMode.srcIn),
          ),
        ),
        Positioned(
          bottom: widget.size.height * 0.15,
          left: -widget.size.width * 0.03,
          child: SvgPicture.asset(
            "assets/svg/img_trush.svg",
            colorFilter:
                ColorFilter.mode(Colors.grey.withAlpha(alpha), BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}
