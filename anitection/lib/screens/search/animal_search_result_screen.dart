import 'dart:developer';

import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/nav_up_button.dart';
import 'package:anitection/components/normal_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/constants.dart';
import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/providers/animal.dart';
import 'package:anitection/providers/favorite_animals_controller.dart';
import 'package:anitection/screens/animal_room/animal_room_profile_dialog.dart';
import 'package:anitection/screens/initial_animal_filter/initial_cat_preference_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimalSearchResultScreen extends ConsumerStatefulWidget {
  const AnimalSearchResultScreen({
    super.key,
    required this.animalKind,
    this.size,
    this.hairLength,
    this.age,
    this.patternIds,
    this.pedigreeIds,
  });

  final String animalKind;
  final List<String>? size;
  final List<String>? hairLength;
  final List<Age>? age;
  final List<int>? patternIds;
  final List<int>? pedigreeIds;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AnimalSearchResultState();
  }
}

class AnimalSearchResultState extends ConsumerState<AnimalSearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    final searchResult =
        ref.watch(searchAnimalFutureProvider(AnimalSearchQueries(
      animalKind: widget.animalKind,
      size: widget.size,
      hairLength: widget.hairLength,
      age: widget.age,
      patternIds: widget.patternIds,
      pedigreeIds: widget.pedigreeIds,
    )));
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E0),
      body: Stack(
        children: [
          const AnimalPadBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NavUpButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      StrokeText(
                        text: "検索結果",
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF573F1B),
                        ),
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(1, 1),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: searchResult.when(
                    data: (data) {
                      log("data length:${data.data.length}");
                      return ListView.separated(
                        itemCount: data.data.length,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemBuilder: (BuildContext context, int index) {
                          return AnimalAvatarCard(
                            animal: data.data[index],
                            onPressed: () {
                              // dialog
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // custom dialog
                                    return AnimalDetailDialogLayout(
                                      animal: data.data[index],
                                      addToFavoriteButtonPressed: () {
                                        Navigator.of(context).pop();
                                        ref.read(favoriteAnimalsControllerProvider.notifier).createFavorite(animalId: data.data[index].id);
                                      },
                                    );
                                  });
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //     const AnimalRoomScreen(animalId: 1)));
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 18,
                          );
                        },
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    error: (error, stackTrace) {
                      log("error: $error, stackTrace: $stackTrace",
                          error: error, stackTrace: stackTrace);
                      return Center(
                        child: Text("エラーが発生しました:$error, $stackTrace"),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AnimalAvatarCard extends StatelessWidget {
  const AnimalAvatarCard(
      {super.key, required this.onPressed, required this.animal});

  final VoidCallback onPressed;
  final Model<AnimalAttributes> animal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Image.asset(
              "assets/images/img_example_cat_avatar.png",
              width: 60,
              height: 60,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StrokeText(
                  text: animal.attributes.name ?? "",
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF444444),
                  ),
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(1, 1),
                    )
                  ],
                ),
                const Text(
                  "あにまる保護施設",
                  textAlign: TextAlign.end,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AnimalDetailDialogLayout extends StatelessWidget {
  const AnimalDetailDialogLayout({super.key, required this.animal, required this.addToFavoriteButtonPressed});

  final Model<AnimalAttributes> animal;
  final VoidCallback addToFavoriteButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFC3EB89),
            width: 5,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: const Color(0xFFC3EB89),
                              width: 5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              AppConstants.mediaServerBaseUrl +
                                  (animal.attributes.realIcon?.data?.attributes
                                          .url ??
                                      ""),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Flexible(
                            child: Column(
                          children: [
                            Text(
                              animal.attributes.name ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF444444),
                                fontSize: 18,
                              ),
                            ),
                            Wrap(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFE39E),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const StrokeText(
                                    text: "性格",
                                    strokeWidth: 2,
                                    strokeColor: Colors.white,
                                    textColor: Color(0xFF444444),
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  animal.attributes.personality ?? "",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF444444),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Text(
                                  "/",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFFC3EB89),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFE39E),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const StrokeText(
                                    text: "好きなもの",
                                    strokeWidth: 2,
                                    strokeColor: Colors.white,
                                    textColor: Color(0xFF444444),
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                // ねこじゃらし
                                Text(
                                  animal.attributes.interest ?? "",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF444444),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                    const AnimalRoomProfileDialogDivider(),
                    // horizontal list
                    SizedBox(
                      height: 90,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: animal.attributes.images?.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFC3EB89),
                                width: 5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                AppConstants.mediaServerBaseUrl +
                                    (animal.attributes.images?.data![index]
                                            .attributes.url ??
                                        ""),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 16,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16,),
                    AddToFavoriteButton(onPressed: addToFavoriteButtonPressed)
                    // NormalButton(onPressed: () {}, child: Row(children: [
                    //   const Icon(Icons.chat_bubble_outline),
                    //   const SizedBox(width: 8,),
                    //   const Text("チャットで問い合わせる"),
                    // ],))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddToFavoriteButton extends StatelessWidget {
  const AddToFavoriteButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return NormalButton(
      width: 219,
      height: 56,
      maxElevation: 6,
      onPressed: onPressed,
      surfaceColor: const Color(0xFFFFDB1D),
      sideColor: const Color(0xFFFFB001),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/ic_add_to_favorite.svg",
            width: 43,
            height: 33,
          ),
          const SizedBox(
            width: 8,
          ),
          const StrokeText(
            text: "登録する",
            strokeWidth: 4,
            strokeColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF573F1B),
            ),
          )
        ],
      ),
    );
  }
}
