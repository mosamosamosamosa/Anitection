import 'package:flutter/material.dart';

class AppBarCurtainItem extends StatelessWidget {
  const AppBarCurtainItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      width: 50,
      decoration: BoxDecoration(
          color: const Color(0xFFC3EB89),
          borderRadius: const BorderRadius.all(
            Radius.elliptical(50, 39),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 2,
            )
          ]),
      child: Stack(
        children: [
          Positioned(
            top: 19,
            left: 20,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppBarCurtain extends StatelessWidget {
  const AppBarCurtain({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: unnecessary_null_comparison
    final count = size == null ? 0 : size.width ~/ 50;

    return Container(
      clipBehavior: Clip.none,
      child: Stack(
        children: List.generate(count + 2, (index) {
          return Positioned(
              top: -19,
              left: index * 50 - 25,
              child: const AppBarCurtainItem());
        }),
      ),
    );
  }
}