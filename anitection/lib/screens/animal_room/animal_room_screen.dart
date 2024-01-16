import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/constants.dart';
import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/providers/animal.dart';
import 'package:anitection/repositories/clean_history_repository.dart';
import 'package:anitection/screens/animal_room/animal_avatar_area.dart';
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
                // onAnimalMovedListener: (offset) {
                //   movedCount++;
                //   final currentState = ref.read(faceStateProvider.notifier).state;
                //   if (movedCount % 13 == 0 && selectedTab == SelectedTab.play) {
                //     // 疲れて寝る
                //     sleepAnimal();
                //   } else if (currentState == FaceStateType.sleeping) {
                //     ref.read(faceStateProvider.notifier).state = FaceStateType.blink;
                //   }
                // },
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

  void updateTabType(SelectedTab tabType) {
    if (selectedTab == SelectedTab.play) {
        ref.read(faceStateProvider.notifier).state = FaceStateType.sleeping;
        Future.delayed(const Duration(milliseconds: 5000), () {
          ref.read(faceStateProvider.notifier).state = FaceStateType.blink;
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


enum SelectedTab {
  food, stroll, clean, play, normal,
}