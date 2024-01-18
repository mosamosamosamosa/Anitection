import 'package:anitection/components/normal_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/constants.dart';
import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/providers/animal.dart';
import 'package:anitection/repositories/clean_history_repository.dart';
import 'package:anitection/screens/animal_room/animal_avatar_area.dart';
import 'package:anitection/screens/animal_room/animal_room_animal_name_label.dart';
import 'package:anitection/screens/animal_room/animal_room_app_bar_curtain.dart';
import 'package:anitection/screens/animal_room/animal_room_bottom_nav_menu.dart';
import 'package:anitection/screens/animal_room/animal_room_door_icon.dart';
import 'package:anitection/screens/animal_room/animal_room_food_selection_pain.dart';
import 'package:anitection/screens/animal_room/animal_room_profile_dialog.dart';
import 'package:anitection/screens/animal_room/animal_room_right_nav_menu.dart';
import 'package:anitection/screens/animal_room/animal_room_trush_background.dart';
import 'package:anitection/screens/animal_room/animal_toy_selection_pain.dart';
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
  ToyType? selectedToy;

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
          CleanBackground(
            size: size,
            lastCleanDateTime: lastCleanDateTime,
            onRoomDirty: () {
              cryAnimal();
            },
          ),
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
                avatarBodyImageUrl: AppConstants.mediaServerBaseUrl + (animalAsyncState.valueOrNull?.data.attributes.avatarBody?.data.attributes.url ?? ""),
                avatarHeadImageUrl: AppConstants.mediaServerBaseUrl + (animalAsyncState.valueOrNull?.data.attributes.avatarHead?.data.attributes.url ?? ""),
                avatarTailImageUrl: AppConstants.mediaServerBaseUrl + (animalAsyncState.valueOrNull?.data.attributes.avatarTail?.data.attributes.url ?? ""),
                isCleanMode: selectedTab == SelectedTab.clean,
                selectedToyType: selectedToy,
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
                    happyAnimal();
                  }
                },
                onCleanComplete: () {
                  whenCleanCompleted();
                },
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
                  giveFood(type);
                },
              )
            ),
          if (selectedTab == SelectedTab.play && selectedToy == null)
            Positioned(
              bottom: 140,
              left: 30,
              right: 30,
              child: ToySelectionPain(
                onToySelectedListener: (type) {
                  setState(() {
                    selectedToy = type;
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
                    updateTabType(SelectedTab.normal);
                  } else {
                    updateTabType(tabType);
                  }
                  selectedToy = null;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void updateTabType(SelectedTab tabType) async {
    if (selectedTab == SelectedTab.play) {
        ref.read(faceStateProvider.notifier).state = FaceStateType.sleeping;
        Future.delayed(const Duration(milliseconds: 5000), () {
          ref.read(faceStateProvider.notifier).state = FaceStateType.blink;
        });
    }
    if (tabType == SelectedTab.stroll) {
      await showDialog(context: context, builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: StrollSelectionDialogLayout(),
        );
      });
    }
    setState(() {
      selectedTab = tabType;
    });
  }
  void sleepAnimal() async {
    final currentState = ref.read(faceStateProvider.notifier).state;
    ref.read(faceStateProvider.notifier).state = FaceStateType.sleeping;
    Future.delayed(const Duration(milliseconds: 5000), () {
      ref.read(faceStateProvider.notifier).state = currentState;
    });
  }

  void whenCleanCompleted() {
    ref.read(effectStateProvider.notifier).state = EffectType.kirakira;
    ref.read(faceStateProvider.notifier).state = FaceStateType.smile;
    ref.read(speechStateProvider.notifier).state = SpeechStateType.none;
    Future.delayed(const Duration(milliseconds: 1500), () {
      ref.read(effectStateProvider.notifier).state = EffectType.none;
      ref.read(faceStateProvider.notifier).state = FaceStateType.blink;
    });
    final now = DateTime.now();
    ref.read(cleanHistoryRepository).setLastCleanDateTime(widget.animalId, now);
    updateTabType(SelectedTab.normal);
    setState(() {
      lastCleanDateTime = now;
    });
  }

  void happyAnimal() {
    ref.read(faceStateProvider.notifier).state = FaceStateType.smile;
    ref.read(effectStateProvider.notifier).state = EffectType.kirakira;
    Future.delayed(const Duration(milliseconds: 800), () {
      ref.read(faceStateProvider.notifier).state = FaceStateType.blink;
      ref.read(effectStateProvider.notifier).state = EffectType.none;
    });
  }

  void cryAnimal() {
    ref.read(faceStateProvider.notifier).state = FaceStateType.sad;
    ref.read(effectStateProvider.notifier).state = EffectType.none;
    ref.read(selectedFoodProvider.notifier).state = FoodType.none;
  }

  void giveFood(FoodType type) {
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


class StrollSelectionDialogLayout extends StatelessWidget {
  const StrollSelectionDialogLayout({super.key});

  @override
  Widget build(BuildContext context) {
    const aspect = 0.36;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFFFDB1D),
            width: 5,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16,),
              const StrokeText(
                text: "おでかけ先の選択",
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
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        width: width * aspect,
                        height: (width * aspect) * (90 / 120),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA6EAFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          "assets/images/img_park.png",
                          fit: BoxFit.cover,
                          width: width * aspect,
                          height: (width * aspect) * (90 / 120),
                        ),
                      ),
                      const Text(
                          "公園",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF573F1B),
                          )
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        width: width * aspect,
                        height: (width * aspect) * (90 / 120),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          "assets/images/img_amusement_park.png",
                          fit: BoxFit.cover,
                          width: width * aspect,
                          height: (width * aspect) * (90 / 120),
                        ),
                      ),
                      const Text(
                          "遊園地",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF573F1B),
                          )
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        width: width * aspect,
                        height: (width * aspect) * (90 / 120),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          "assets/images/img_shopping_street.png",
                          fit: BoxFit.cover,
                          width: width * aspect,
                          height: (width * aspect) * (90 / 120),
                        ),
                      ),
                      const Text(
                          "商店街",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF573F1B),
                          )
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        width: width * aspect,
                        height: (width * aspect) * (90 / 120),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          "assets/images/img_seaside.png",
                          fit: BoxFit.cover,
                          width: width * aspect,
                          height: (width * aspect) * (90 / 120),
                        ),
                      ),
                      const Text(
                          "海辺",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF573F1B),
                          )
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NormalButton(
                    onPressed: () {

                    },
                    width: 127,
                    height: 55,
                    maxElevation: 8,
                    surfaceColor: const Color(0xFFC9C9C9),
                    sideColor: const Color(0xFFA2A2A2),
                    child: const StrokeText(
                      text: "キャンセル",
                      textColor: Color(0xFF573F1B),
                      strokeColor: Colors.white,
                      strokeWidth: 2,
                      shadows: [
                        Shadow(
                          color: Color(0xFF573F1B),
                          offset: Offset(2, 2),
                          blurRadius: 10,
                        ),
                      ],
                      textStyle: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  NormalButton(
                    onPressed: () {

                    },
                    width: 127,
                    height: 55,
                    maxElevation: 8,
                    surfaceColor: const Color(0xFFFFDB1D),
                    sideColor: const Color(0xFFFFB001),
                    child: const StrokeText(
                      text: "出発",
                      textColor: Color(0xFF573F1B),
                      strokeColor: Colors.white,
                      strokeWidth: 2,
                      shadows: [
                        Shadow(
                          color: Color(0xFF573F1B),
                          offset: Offset(2, 2),
                          blurRadius: 10,
                        ),
                      ],
                      textStyle: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
            ],
          ),
        )
    );
  }
}

enum SelectedTab {
  food, stroll, clean, play, normal,
}