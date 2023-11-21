import 'package:flutter/cupertino.dart';

class NormalButton extends StatefulWidget {
  const NormalButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.surfaceColor = const Color(0xFFC3EB89),
    this.sideColor = const Color(0xFFAFCD83),
    this.borderRadius = 40,
    this.maxElevation = 4,
    this.contentPadding,
    this.height,
    this.width,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final Color surfaceColor;
  final Color sideColor;
  final double borderRadius;
  final double maxElevation;
  final EdgeInsetsGeometry? contentPadding;
  final double? width;
  final double? height;

  @override
  State<StatefulWidget> createState() {
    return NormalButtonState();
  }
}

class NormalButtonState extends State<NormalButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationTween;
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animationTween = Tween<double>(begin: widget.maxElevation, end: 0).animate(
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
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: widget.sideColor,
            ),
            padding: widget.contentPadding,
            width: widget.width,
            height: widget.height,
            child: widget.child,
          ),
          Positioned(
            top: -_animationTween.value,
            child: Container(
              padding: widget.contentPadding,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: widget.surfaceColor,
              ),
              height: widget.height,
              width: widget.width,
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
