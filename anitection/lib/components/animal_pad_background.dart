
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class AnimalPadBackground extends StatelessWidget {
  const AnimalPadBackground({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(100, (index) {
        double screenWidth = MediaQuery.of(context).size.width;
        double dotSize = 50.0;
        double space = 50.0;
        double spaceY = 25.0;

        int dotsPerRow = (screenWidth / (dotSize)).floor();
        int xIndex = index % dotsPerRow;
        int yIndex = (index / dotsPerRow).floor();
        bool isOddRow = yIndex.isOdd;

        double xOffset = (dotSize + space) * xIndex + (isOddRow ? (space + dotSize) / 2 : 0);
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