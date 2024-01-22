import 'dart:async';

import 'package:anitection/constants.dart';
import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/providers/animal.dart';
import 'package:anitection/repositories/clean_history_repository.dart';
import 'package:anitection/repositories/stroll_repository.dart';
import 'package:anitection/screens/animal_room/animal_avatar_area.dart';
import 'package:anitection/screens/animal_room/animal_room_animal_name_label.dart';
import 'package:anitection/screens/animal_room/animal_room_app_bar_curtain.dart';
import 'package:anitection/screens/animal_room/animal_room_bottom_nav_menu.dart';
import 'package:anitection/screens/animal_room/animal_room_door_icon.dart';
import 'package:anitection/screens/animal_room/animal_room_food_selection_pain.dart';
import 'package:anitection/screens/animal_room/animal_room_omiyage_dialog.dart';
import 'package:anitection/screens/animal_room/animal_room_profile_dialog.dart';
import 'package:anitection/screens/animal_room/animal_room_right_nav_menu.dart';
import 'package:anitection/screens/animal_room/animal_room_stroll_selection_dialog.dart';
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
  bool isStroll = false;
  StreamSubscription<bool>? isStrolledStreamSubscription;

  @override
  void initState() {
    ref.read(cleanHistoryRepository).getLastCleanDateTime(widget.animalId).then((value) {
      setState(() {
        lastCleanDateTime = value;
      });
    });
    ref.read(strollRepositoryProvider).isStrolled(animalId: widget.animalId).then((value) {
      setState(() {
        isStroll = value;
      });
    });
    isStrolledStreamSubscription = ref.read(strollRepositoryProvider).isStrolledStream(animalId: widget.animalId).listen((event) {
      final isWhenComeBack = event == false && isStroll == true;
      if (isWhenComeBack) {
        ref.read(speechStateProvider.notifier).state = SpeechStateType.present4You;
        ref.read(faceStateProvider.notifier).state = FaceStateType.smile;
      }
      setState(() {
        if (isWhenComeBack) {
          selectedTab = SelectedTab.normal;
        }
        isStroll = event;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    isStrolledStreamSubscription?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final animalAsyncState = ref.watch(animalFutureProvider(widget.animalId));
    final size = MediaQuery.of(context).size;
    final speechState = ref.watch(speechStateProvider);
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
            animalId: widget.animalId,
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
              child: isStroll ? const AnimalNameLabel(
                name: "お散歩中・・・",
              ):  AnimalNameLabel(
                name: animalAsyncState.valueOrNull?.data.attributes.name ?? "",
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.5,
            child: isStroll ? Container() : Container(
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
                  if (speechState == SpeechStateType.present4You) {
                    await showDialog(context: context, builder: (BuildContext context) {
                      return const AnimalRoomOmiyageDialog();
                    });
                    ref.read(speechStateProvider.notifier).state = SpeechStateType.none;
                    final level = await ref.read(cleanHistoryRepository).getDirtyLevel(widget.animalId);
                    if (level == 255) {
                      cryAnimal();
                    } else {
                      ref.read(faceStateProvider.notifier).state = FaceStateType.blink;
                    }
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
      final result = await showDialog<StrollLocation?>(context: context, builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const StrollSelectionDialogLayout(),
        );
      });
      if (result == null) {
        return;
      } else {
        await ref.read(strollRepositoryProvider).create(animalId: widget.animalId);
        final isStrolled = await ref.read(strollRepositoryProvider).isStrolled(animalId: widget.animalId);
        setState(() {
          isStroll = isStrolled;
        });
      }
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



enum SelectedTab {
  food, stroll, clean, play, normal,
}