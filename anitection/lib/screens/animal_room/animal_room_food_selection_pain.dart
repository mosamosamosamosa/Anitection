
import 'package:anitection/screens/animal_room/animal_avatar_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef OnFoodSelectedListener = void Function(FoodType type);
class FoodSelectionPain extends StatelessWidget {
  const FoodSelectionPain({super.key, required this.onFoodSelectedListener});
  final OnFoodSelectedListener onFoodSelectedListener;

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
              onFoodSelectedListener(FoodType.karikari);
            },
            child: Image.asset("assets/images/img_karikari.png", height: 40),
          ),
          GestureDetector(
            onTap: () {
              onFoodSelectedListener(FoodType.maguro);
            },
            child: Image.asset("assets/images/img_maguro.png", height: 40),
          ),
          GestureDetector(
            onTap: () {
              onFoodSelectedListener(FoodType.nekocan);
            },
            child: Image.asset("assets/images/img_nekocan.png", height: 40),
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
