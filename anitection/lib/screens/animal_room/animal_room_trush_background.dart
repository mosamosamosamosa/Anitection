
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CleanBackground extends StatefulWidget {
  final Size size;
  final DateTime? lastCleanDateTime;
  final VoidCallback? onRoomDirty;

  const CleanBackground({super.key, required this.size, required this.lastCleanDateTime, this.onRoomDirty});
  @override
  State<StatefulWidget> createState() {
    return CleanBackgroundState();
  }
}

class CleanBackgroundState extends State<CleanBackground> {
  DateTime now = DateTime.now();
  int alpha = 0;
  @override
  void initState() {
    Future.microtask(() async {
      while(true) {
        await Future.delayed(const Duration(seconds: 1), () {
          final beforeAlpha = alpha;
          setState(() {
            now = DateTime.now();
            alpha = (widget.lastCleanDateTime == null ? 255 : ((now.difference(widget.lastCleanDateTime!).inSeconds / 1).floor())).clamp(0, 255);
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
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: widget.size.height * 0.15,
          left: -widget.size.width * 0.05,
          child: SvgPicture.asset("assets/svg/img_trush.svg", colorFilter: ColorFilter.mode(Colors.grey.withAlpha(alpha), BlendMode.srcIn),),
        ),
        Positioned(
          top: widget.size.height * 0.3,
          right: -widget.size.width * 0.05,
          child: SvgPicture.asset("assets/svg/img_trush.svg", colorFilter: ColorFilter.mode(Colors.grey.withAlpha(alpha), BlendMode.srcIn),),
        ),
        Positioned(
          bottom: widget.size.height * 0.15,
          left: -widget.size.width * 0.03,
          child: SvgPicture.asset(
            "assets/svg/img_trush.svg",
            colorFilter: ColorFilter.mode(Colors.grey.withAlpha(alpha), BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}
