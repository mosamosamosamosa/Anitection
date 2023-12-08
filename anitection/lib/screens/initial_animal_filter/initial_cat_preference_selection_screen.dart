import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/normal_button.dart';
import 'package:anitection/components/number_stepper.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/screens/initial_animal_filter/initial_cat_pattern_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitialCatPreferenceSelectionScreen extends ConsumerStatefulWidget {
  const InitialCatPreferenceSelectionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return InitialCatPreferenceSelectionScreenState();
  }
}

class InitialCatPreferenceSelectionScreenState
    extends ConsumerState<InitialCatPreferenceSelectionScreen> {
  final Set<CatHairLength> catHairLength = {};
  final Set<CatAge> catAge = {};
  final Set<CatSize> catSize = {};

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.7;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E0),
      body: Stack(
        children: [
          const AnimalPadBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: NumberStepper(
                      width: width,
                      curStep: 2,
                      stepCompleteColor: const Color(0xFFC3EB89),
                      totalSteps: 3,
                      inactiveColor: const Color(0xFFD9D9D9),
                      currentStepColor: const Color(0xFFD9D9D9),
                      lineWidth: 6,
                    ),
                  ),
                  StrokeText(
                    text: "あなたの猫の好みを\n教えてください",
                    strokeColor: Colors.white,
                    textColor: const Color(0xFF573F1B),
                    textAlign: TextAlign.center,
                    strokeWidth: 4,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.25),
                        offset: const Offset(2, 2),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StrokeText(
                        text: "毛の長さ",
                        strokeColor: Colors.white,
                        textColor: const Color(0xFF573F1B),
                        textAlign: TextAlign.center,
                        strokeWidth: 4,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(2, 2),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CatPreferenceSelectionButton(
                            onPressed: () {
                              onCatHairLengthButtonPressed(CatHairLength.long);
                            },
                            text: "長毛",
                            isSelected:
                                catHairLength.contains(CatHairLength.long),
                          ),
                          CatPreferenceSelectionButton(
                            onPressed: () {
                              onCatHairLengthButtonPressed(CatHairLength.short);
                            },
                            text: "短毛",
                            isSelected:
                                catHairLength.contains(CatHairLength.short),
                          ),
                          CatPreferenceSelectionButton(
                            onPressed: () {
                              onCatHairLengthButtonPressed(
                                  CatHairLength.hairless);
                            },
                            text: "無毛",
                            isSelected:
                                catHairLength.contains(CatHairLength.hairless),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      StrokeText(
                        text: "サイズ",
                        strokeColor: Colors.white,
                        textColor: const Color(0xFF573F1B),
                        textAlign: TextAlign.center,
                        strokeWidth: 4,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(2, 2),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CatPreferenceSelectionButton(
                            onPressed: () {
                              onSizeButtonPressed(CatSize.large);
                            },
                            text: "大きめ",
                            isSelected: catSize.contains(CatSize.large),
                          ),
                          CatPreferenceSelectionButton(
                            onPressed: () {
                              onSizeButtonPressed(CatSize.medium);
                            },
                            text: "普通",
                            isSelected: catSize.contains(CatSize.medium),
                          ),
                          CatPreferenceSelectionButton(
                            onPressed: () {
                              onSizeButtonPressed(CatSize.small);
                            },
                            text: "小さめ",
                            isSelected: catSize.contains(CatSize.small),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      StrokeText(
                        text: "年齢",
                        strokeColor: Colors.white,
                        textColor: const Color(0xFF573F1B),
                        textAlign: TextAlign.center,
                        strokeWidth: 4,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(2, 2),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CatPreferenceSelectionButton(
                            onPressed: () {
                              onCatAgeButtonPressed(CatAge.adult);
                            },
                            text: "成猫",
                            isSelected: catAge.contains(CatAge.adult),
                          ),
                          CatPreferenceSelectionButton(
                            onPressed: () {
                              onCatAgeButtonPressed(CatAge.kitten);
                            },
                            text: "子猫",
                            isSelected: catAge.contains(CatAge.kitten),
                          ),
                          CatPreferenceSelectionButton(
                            onPressed: () {
                              onCatAgeButtonPressed(CatAge.senior);
                            },
                            text: "シニア猫",
                            isSelected: catAge.contains(CatAge.senior),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CancelButton(onPressed: () {
                        Navigator.of(context).pop();
                      }),
                      const SizedBox(width: 16),
                      NextButton(onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return InitialCatPatternScreen(
                                  catHairLength: catHairLength,
                                  catAge: catAge,
                                  catSize: catSize);
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void onSizeButtonPressed(CatSize size) {
    setState(() {
      if (catSize.contains(size)) {
        catSize.remove(size);
      } else {
        catSize.add(size);
      }
    });
  }

  void onCatHairLengthButtonPressed(CatHairLength hairLength) {
    setState(() {
      if (catHairLength.contains(hairLength)) {
        catHairLength.remove(hairLength);
      } else {
        catHairLength.add(hairLength);
      }
    });
  }

  void onCatAgeButtonPressed(CatAge age) {
    setState(() {
      if (catAge.contains(age)) {
        catAge.remove(age);
      } else {
        catAge.add(age);
      }
    });
  }
}

class CatPreferenceSelectionButton extends StatelessWidget {
  const CatPreferenceSelectionButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isSelected,
  });

  final VoidCallback onPressed;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100,
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: isSelected
              ? Border.all(
                  color: const Color(0xFFFFB001),
                  width: 1.0,
                )
              : null,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: StrokeText(
          text: text,
          strokeColor: Colors.white,
          textColor: const Color(0xFF573F1B),
          textAlign: TextAlign.center,
          strokeWidth: 4,
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          shadows: [
            Shadow(
              blurRadius: 4,
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(2, 2),
            )
          ],
        ),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return NormalButton(
      width: 160,
      height: 56,
      surfaceColor: const Color(0xFFC7C7C7),
      sideColor: const Color(0xFF888888),
      maxElevation: 6,
      onPressed: onPressed,
      child: const StrokeText(
        text: "キャンセル",
        strokeWidth: 4,
        strokeColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF573F1B),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return NormalButton(
      width: 160,
      height: 56,
      maxElevation: 6,
      onPressed: onPressed,
      child: const StrokeText(
        text: "次へ",
        strokeWidth: 4,
        strokeColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF573F1B),
        ),
      ),
    );
  }
}

enum CatSize {
  large,
  medium,
  small,
}

enum CatAge {
  adult,
  kitten,
  senior,
}

enum CatHairLength {
  long,
  short,
  hairless,
}
