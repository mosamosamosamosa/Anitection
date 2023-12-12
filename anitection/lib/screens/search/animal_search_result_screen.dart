import 'dart:developer';

import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/nav_up_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/providers/animal.dart';
import 'package:anitection/screens/initial_animal_filter/initial_cat_preference_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimalSearchResultScreen extends ConsumerStatefulWidget {
  const AnimalSearchResultScreen(
      {super.key,
      required this.animalKind,
      required this.size,
      required this.hairLength,
      required this.age,
      required this.patternIds});

  final String animalKind;
  final List<String> size;
  final List<String>? hairLength;
  final List<Age>? age;
  final List<int>? patternIds;

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
