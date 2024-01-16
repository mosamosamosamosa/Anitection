
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RightNavMenu extends StatelessWidget {
  const RightNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 60,
      decoration: BoxDecoration(
        color: const Color(0xB2D9D9D9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 2,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(4),
            child: SvgPicture.asset("assets/svg/ic_heart.svg"),
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset("assets/images/img_offering_box.png"),
          ),
        ],
      ),
    );
  }
}
