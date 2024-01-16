import 'package:anitection/screens/animal_room/animal_avatar_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef OnToySelectionListener = void Function(ToyType type);
class ToySelectionPain extends StatelessWidget {
  const ToySelectionPain({super.key, required this.onToySelectedListener});
  final OnToySelectionListener onToySelectedListener;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 2,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          GestureDetector(
            onTap: () {
              onToySelectedListener(ToyType.nekojarashi);
            },
            child: SvgPicture.asset("assets/svg/img_nekojarashi.svg", height: 40),
          ),
          GestureDetector(
            onTap: () {
              onToySelectedListener(ToyType.ball);
            },
            child: SvgPicture.asset("assets/svg/img_ball.svg", height: 40),
          ),
          GestureDetector(
            onTap: () {
              onToySelectedListener(ToyType.fish);
            },
            child: SvgPicture.asset("assets/svg/img_fish.svg", height: 40),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFAE2),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 2,
                )
              ],
            ),
            child: SvgPicture.asset("assets/svg/ic_add_animal.svg"),
          )
        ],
      ),
    );
  }
}
