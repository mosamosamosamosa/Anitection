import 'dart:developer';

import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/providers/animal.dart';
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
        child: Container(
          color: Color(0xFFC3EB89),
          child: Column(children: []),
        ),
        preferredSize: Size.fromHeight(size.height * 0.1),
      ),
      body: Stack(children: [
        const AnimalRoomBackground(),
        AppBarCurtain(),
      ]),
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
          color: Color(0xFFC3EB89),
          borderRadius: BorderRadius.all(
            Radius.elliptical(50, 39),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 4),
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
              top: -19, left: index * 50 - 25, child: const AppBarCurtainItem());
        }),
      ),
    );
  }
}
