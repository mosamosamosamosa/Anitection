import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class AnimalPadBackground extends StatelessWidget {
  const AnimalPadBackground({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dotSize = 50.0;
    double space = 50.0;
    double spaceY = 25.0;
    final double screenHeight = MediaQuery.of(context).size.height;
    final generateCount = (screenHeight / (dotSize)).ceil() * screenWidth / (dotSize).ceil();
    return Stack(
      children: List.generate(generateCount.toInt(), (index) {
        int dotsPerRow = (screenWidth / (dotSize)).floor();
        int xIndex = index % dotsPerRow;
        int yIndex = (index / dotsPerRow).floor();
        bool isOddRow = yIndex.isOdd;

        double xOffset =
            (dotSize + space) * xIndex + (isOddRow ? (space + dotSize) / 2 : 0);
        double yOffset = (dotSize + spaceY) * yIndex;

        return Positioned(
          left: xOffset,
          top: yOffset,
          child: SvgPicture.asset(
            'assets/svg/img_animal_pad.svg',
            width: dotSize,
            height: dotSize,
            color: const Color(0xFFF5EED8),
          ),
        );
      }),
    );
  }
}
