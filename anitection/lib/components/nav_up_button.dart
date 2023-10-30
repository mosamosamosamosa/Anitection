
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavUpButton extends StatelessWidget {
  const NavUpButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(

      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 38,
        height: 38,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFFFB001),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(2, 4, 4, 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFFFDB1D),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/svg/ic_arrow_left_orange.svg",
            ),
          ),
        ),
      ),
    );
  }
}