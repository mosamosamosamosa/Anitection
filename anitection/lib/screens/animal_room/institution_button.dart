import 'package:anitection/components/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InstitutionButton extends StatefulWidget {
  const InstitutionButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<StatefulWidget> createState() {
    return InstitutionButtonState();
  }
}

class InstitutionButtonState extends State<InstitutionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationTween;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animationTween = Tween<double>(begin: 8, end: 0).animate(
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
      onPanDown: (_) {
        _animationController.forward(from: 0);
      },
      onPanCancel: () {
        _animationController.reverse();
      },
      onPanEnd: (_) {
        _animationController.reverse();
      },
      onTap: () {
        widget.onPressed();
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 90,
            height: 90,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD9D9D9),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
          ),
          Positioned(
            bottom: _animationTween.value,
            child: Container(
              width: 90,
              height: 90,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFDF90),
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 10,
                    child: SvgPicture.asset(
                      "assets/svg/ic_institution.svg",
                      width: 40,
                      height: 32,
                    ),
                  ),
                  const Positioned(
                    top: 32,
                    child: StrokeText(
                      text: "施設へ",
                      textColor: Color(0xFFC39248),
                      strokeColor: Colors.white,
                      strokeWidth: 2,
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
