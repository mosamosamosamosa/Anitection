import 'dart:math';

import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/constants.dart';
import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/providers/animal.dart';
import 'package:anitection/repositories/clean_history_repository.dart';
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
  SelectedTab selectedTab = SelectedTab.normal;
  DateTime? lastCleanDateTime;

  @override
  void initState() {
    ref.read(cleanHistoryRepository).getLastCleanDateTime(widget.animalId).then((value) {
      setState(() {
        lastCleanDateTime = value;
      });
    });
    super.initState();
  }
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
            CleanBackground(size: size, lastCleanDateTime: lastCleanDateTime,),
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
              child: selectedTab == SelectedTab.stroll ? const AnimalNameLabel(
                name: "お散歩中・・・",
              ):  AnimalNameLabel(
                name: animalAsyncState.valueOrNull?.data.attributes.name ?? "",
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.5,
            child: selectedTab == SelectedTab.stroll ? Container() : Container(
              width: size.width,
              alignment: Alignment.center,
              child: AnimalAvatarArea(
                size: Size(size.width, size.height),
                avatarImageUrl: AppConstants.mediaServerBaseUrl + (animalAsyncState.valueOrNull?.data.attributes.avatarIcon?.data.attributes.url ?? ""),
                avatarSize: () {
                  final data = animalAsyncState.valueOrNull;
                  if (data != null) {
                    final width = data.data.attributes.avatarIcon?.data.attributes.width ?? 0;
                    final height = data.data.attributes.avatarIcon?.data.attributes.height ?? 0;
                    return Size(width.toDouble(), height.toDouble());
                  }
                  return const Size(0, 0);
                }(),
                onAvatarTap: () async {
                  final data = animalAsyncState.valueOrNull;
                  if (selectedTab == SelectedTab.clean) {
                    return;
                  }
                  if (data != null && selectedTab != SelectedTab.play) {
                    showAnimalRoomProfileDialog(context, size, data.data);
                  }  else {
                    ref.read(faceStateProvider.notifier).state = FaceStateType.smile;
                    ref.read(effectStateProvider.notifier).state = EffectType.kirakira;
                    Future.delayed(const Duration(milliseconds: 800), () {
                      ref.read(faceStateProvider.notifier).state = FaceStateType.blink;
                      ref.read(effectStateProvider.notifier).state = EffectType.none;
                    });
                  }
                },
                onCleanComplete: () {
                  ref.read(effectStateProvider.notifier).state = EffectType.kirakira;
                  ref.read(faceStateProvider.notifier).state = FaceStateType.smile;
                  ref.read(speechStateProvider.notifier).state = SpeechStateType.none;
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    ref.read(effectStateProvider.notifier).state = EffectType.none;
                    ref.read(faceStateProvider.notifier).state = FaceStateType.blink;
                  });
                  final now = DateTime.now();
                  ref.read(cleanHistoryRepository).setLastCleanDateTime(widget.animalId, now);
                  setState(() {
                    selectedTab = SelectedTab.normal;
                    lastCleanDateTime = now;
                  });
                },
                avatarBodyImageUrl: AppConstants.mediaServerBaseUrl + (animalAsyncState.valueOrNull?.data.attributes.avatarBody?.data.attributes.url ?? ""),
                avatarHeadImageUrl: AppConstants.mediaServerBaseUrl + (animalAsyncState.valueOrNull?.data.attributes.avatarHead?.data.attributes.url ?? ""),
                avatarTailImageUrl: AppConstants.mediaServerBaseUrl + (animalAsyncState.valueOrNull?.data.attributes.avatarTail?.data.attributes.url ?? ""),
                isCleanMode: selectedTab == SelectedTab.clean,
              ),
            ),
          ),
          Positioned(
            bottom: -83,
            left: -116,
            child: DoorIcon(
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          if (selectedTab == SelectedTab.food)
            Positioned(
              bottom: 140,
              left: 30,
              right: 30,
              child: FoodSelectionPain(
                onFoodSelectedListener: (type) {
                  ref.read(selectedFoodProvider.notifier).state = type;
                  ref.read(effectStateProvider.notifier).state = EffectType.kirakira;
                  ref.read(faceStateProvider.notifier).state = FaceStateType.smile;
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    ref.read(effectStateProvider.notifier).state = EffectType.none;
                    ref.read(faceStateProvider.notifier).state = FaceStateType.blink;
                  });
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    ref.read(selectedFoodProvider.notifier).state = FoodType.none;
                  });
                },
              )
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimalRoomBottomNavMenu(
              selectedTab: selectedTab,
              onMenuSelectedListener: (tabType) {
                setState(() {
                  if (selectedTab == tabType) {
                    selectedTab = SelectedTab.normal;
                  } else {
                    selectedTab = tabType;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

typedef OnMenuSelectedListener = void Function(SelectedTab selectedTab);
class AnimalRoomBottomNavMenu extends StatelessWidget {
  const AnimalRoomBottomNavMenu({super.key, this.selectedTab = SelectedTab.normal, required this.onMenuSelectedListener});
  final SelectedTab selectedTab;
  final OnMenuSelectedListener onMenuSelectedListener;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemSize = min((width - 80) / 4 - ((width - 80) / 4 * 0.1), 70.0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          width: 80,
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                onMenuSelectedListener(SelectedTab.food);
              },
              child: Stack(
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
            ),
            Container(
              width: 3,
              height: selectedTab == SelectedTab.food ? 22 : 44,
              color: const Color(0xFFC3EB89),
            )
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                onMenuSelectedListener(SelectedTab.stroll);
              },
              child: Stack(
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
            ),
            Container(
              width: 3,
              height: selectedTab == SelectedTab.stroll ? 22 : 44,
              color: const Color(0xFFFFB001),
            )
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                onMenuSelectedListener(SelectedTab.clean);
              },
              child: Stack(
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
            ),
            Container(
              width: 3,
              height: selectedTab == SelectedTab.clean ? 22 : 44,
              color: const Color(0xFFC6DEE8),
            )
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                onMenuSelectedListener(SelectedTab.play);
              },
              child: Stack(
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
            ),
            Container(
              width: 3,
              height: selectedTab == SelectedTab.play ? 22 : 44,
              color: const Color(0xFFFFDB1D),
            )
          ],
        )
      ],
    );
  }
}

class DoorIcon extends StatelessWidget {
  const DoorIcon({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPressed,
      child: Container(
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
      ),
    );
  }
}

class AnimalNameLabel extends StatelessWidget {
  const AnimalNameLabel({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return StrokeText(
      text: name,
      strokeColor: Colors.white,
      textColor: const Color(0xFF573F1B),
      textAlign: TextAlign.center,
      strokeWidth: 4,
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      shadows: const [
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

class CleanBackground extends StatefulWidget {
  final Size size;
  final DateTime? lastCleanDateTime;

  const CleanBackground({super.key, required this.size, required this.lastCleanDateTime});
  @override
  State<StatefulWidget> createState() {
    return CleanBackgroundState();
  }
}

class CleanBackgroundState extends State<CleanBackground> {

  DateTime now = DateTime.now();
  @override
  void initState() {
    Future.microtask(() async {
      while(true) {
        await Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            now = DateTime.now();
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final alpha = (widget.lastCleanDateTime == null ? 255 : ((now.difference(widget.lastCleanDateTime!).inSeconds / 1).floor())).clamp(0, 255);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: widget.size.height * 0.15,
          left: -widget.size.width * 0.05,
          child: SvgPicture.asset("assets/svg/img_trush.svg", colorFilter: ColorFilter.mode(Colors.grey.withAlpha(alpha), BlendMode.srcIn),),
        ),
        Positioned(
          top: widget.size.height * 0.3,
          right: -widget.size.width * 0.05,
          child: SvgPicture.asset("assets/svg/img_trush.svg", colorFilter: ColorFilter.mode(Colors.grey.withAlpha(alpha), BlendMode.srcIn),),
        ),
        Positioned(
            bottom: widget.size.height * 0.15,
            left: -widget.size.width * 0.03,
            child: SvgPicture.asset(
              "assets/svg/img_trush.svg",
              colorFilter: ColorFilter.mode(Colors.grey.withAlpha(alpha), BlendMode.srcIn),
            ),
        ),
      ],
    );
  }
}

enum SelectedTab {
  food, stroll, clean, play, normal,
}