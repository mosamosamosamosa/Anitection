
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoorIcon extends StatelessWidget {
  const DoorIcon({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPressed,
      child: Container(
        // 楕円
        width: 209,
        height: 177,
        decoration: BoxDecoration(
          color: const Color(0xFFE4E4E4),
          borderRadius: const BorderRadius.all(
            Radius.elliptical(209, 177),
          ),
          border: Border.all(
            color: const Color(0xFFFFFFFF),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(4, -4),
              blurRadius: 4,
            )
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 27,
              right: 34,
              child: SvgPicture.asset("assets/svg/ic_door.svg"),
            )
          ],
        ),
      ),
    );
  }
}
