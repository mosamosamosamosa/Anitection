import 'dart:math';

import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/providers/animal.dart';
import 'package:anitection/screens/animal_room/animal_avatar_area.dart';
import 'package:anitection/screens/animal_room/animal_room_profile_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimalRoomScreen extends ConsumerStatefulWidget {
  const AnimalRoomScreen({super.key, required this.animalId});

  final int animalId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AnimalRoomScreenState();
  }
}

class AnimalRoomScreenState extends ConsumerState<AnimalRoomScreen> {
  @override
  Widget build(BuildContext context) {
    final animalAsyncState = ref.watch(animalFutureProvider(widget.animalId));
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          color: const Color(0xFFC3EB89),
          child: const Column(children: []),
        ),
      ),
      body: Stack(
        children: [
          const AnimalRoomBackground(),
          const AppBarCurtain(),
          const Positioned(
            top: 40,
            right: 14,
            child: RightNavMenu(),
          ),
          Positioned(
            top: size.height * 0.2,
            child: Container(
              alignment: Alignment.center,
              width: size.width,
              child: const AnimalNameLabel(),
            ),
          ),
          Positioned(
            top: size.height * 0.5,
            child: Container(
              width: size.width,
              alignment: Alignment.center,
              child: AnimalAvatarArea(size: Size(size.width, size.height)),
            ),
          ),
          const Positioned(
            bottom: -83,
            left: -116,
            child: DoorIcon(),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimalRoomBottomNavMenu(),
          ),
        ],
      ),
    );
  }
}

class AnimalRoomBottomNavMenu extends StatelessWidget {
  const AnimalRoomBottomNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemSize = min((width - 80) / 4 - ((width - 80) / 4 * 0.1), 70.0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          width: 80,
        ),
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: itemSize,
                  height: itemSize,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFCF3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFC3EB89),
                      width: 3,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  "assets/svg/ic_dinner.svg",
                  width: itemSize * 0.57,
                  height: itemSize * 0.57,
                ),
              ],
            ),
            Container(
              width: 3,
              height: 43,
              color: const Color(0xFFC3EB89),
            )
          ],
        ),
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: itemSize,
                  height: itemSize,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFCF3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFFB001),
                      width: 3,
                    ),
                  ),
                ),
                SvgPicture.asset("assets/svg/ic_tree.svg",
                    width: itemSize * 0.57, height: itemSize * 0.57),
              ],
            ),
            Container(
              width: 3,
              height: 43,
              color: const Color(0xFFFFB001),
            )
          ],
        ),
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: itemSize,
                  height: itemSize,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFCF3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFC6DEE8),
                      width: 3,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  "assets/svg/ic_bucket.svg",
                  width: itemSize * 0.57,
                  height: itemSize * 0.57,
                ),
              ],
            ),
            Container(
              width: 3,
              height: 43,
              color: const Color(0xFFC6DEE8),
            )
          ],
        ),
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: itemSize,
                  height: itemSize,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFCF3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFFDB1D),
                      width: 3,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  "assets/svg/ic_stop_hand.svg",
                  width: itemSize * 0.57,
                  height: itemSize * 0.57,
                ),
              ],
            ),
            Container(
              width: 3,
              height: 43,
              color: const Color(0xFFFFDB1D),
            )
          ],
        )
      ],
    );
  }
}

class DoorIcon extends StatelessWidget {
  const DoorIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // 楕円
      width: 209,
      height: 177,
      decoration: BoxDecoration(
        color: const Color(0xFFE4E4E4),
        borderRadius: const BorderRadius.all(
          Radius.elliptical(209, 177),
        ),
        border: Border.all(
          color: const Color(0xFFFFFFFF),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(4, -4),
            blurRadius: 4,
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 27,
            right: 34,
            child: SvgPicture.asset("assets/svg/ic_door.svg"),
          )
        ],
      ),
    );
  }
}

class AnimalNameLabel extends StatelessWidget {
  const AnimalNameLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return const StrokeText(
      text: "あるるくんのお部屋",
      strokeColor: Colors.white,
      textColor: Color(0xFF573F1B),
      textAlign: TextAlign.center,
      strokeWidth: 4,
      textStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      shadows: [
        Shadow(
          blurRadius: 10,
          color: Colors.black,
          offset: Offset(2, 2),
        )
      ],
    );
  }
}

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

Future<void> showAnimalRoomProfileDialog(
  BuildContext context,
  Size screenSize,
  Model<AnimalAttributes> animal,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.75,
        child: AnimalRoomProfileDialog(
          height: screenSize.height * 0.9,
          animal: animal,
        ),
      );
    },
  );
}

class AnimalRoomBackground extends StatelessWidget {
  const AnimalRoomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/svg/img_animal_room_background.svg",
        fit: BoxFit.cover);
  }
}

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
