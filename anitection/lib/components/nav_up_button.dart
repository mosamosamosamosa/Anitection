import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class NavUpButton extends StatefulWidget {
  const NavUpButton({super.key, required this.onPressed});

  final VoidCallback onPressed;
  @override
  State<StatefulWidget> createState() {
    return NavUpButtonState();
  }
}

class NavUpButtonState extends State<NavUpButton> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  late Animation<double> _animationTween;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animationTween = Tween<double>(begin: 4, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      onPanDown: (_) {
        _animationController.forward(from: 0);
      },
      onPanCancel: () {
        _animationController.reverse();
      },
      onPanEnd: (_) {
        _animationController.reverse();
      },
      child: Material(
        elevation: _animationTween.value,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
      ),
    );
  }
}
