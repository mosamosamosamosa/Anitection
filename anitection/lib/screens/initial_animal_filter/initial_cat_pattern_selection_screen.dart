import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/number_stepper.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/screens/initial_animal_filter/initial_cat_preference_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitialCatPatternScreen extends ConsumerStatefulWidget {
  const InitialCatPatternScreen(
      {super.key,
      required this.catHairLength,
      required this.catAge,
      required this.catSize});

  final Set<CatHairLength> catHairLength;
  final Set<CatAge> catAge;
  final Set<CatSize> catSize;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return InitialCatPatternState();
  }
}

class InitialCatPatternState extends ConsumerState<InitialCatPatternScreen> {
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: NumberStepper(
                      width: width,
                      curStep: 3,
                      stepCompleteColor: const Color(0xFFC3EB89),
                      totalSteps: 3,
                      inactiveColor: const Color(0xFFD9D9D9),
                      currentStepColor: const Color(0xFFD9D9D9),
                      lineWidth: 6,
                    ),
                  ),
                  StrokeText(
                    text: "あなたの好きな猫の色・模様を\n教えてください",
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
                  const SizedBox(
                    height: 32,
                  ),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(2, 2),
                          )
                        ],
                      ),
                      child: GridView.builder(
                        itemCount: 100,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 32),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 110, crossAxisSpacing: 4, mainAxisSpacing: 4),
                        itemBuilder: (BuildContext context, int index) {
                          return PatternSelectionItem(selected: index % 5 == 0);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
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
                      NextButton(onPressed: () {}),
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
}

class PatternSelectionItem extends StatelessWidget {
  const PatternSelectionItem({super.key, required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: selected ? 85 : 80,
          height:  selected ? 85 : 80,
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(10),
            border: selected ? Border.all(color: const Color(0xFFFFB001), width: 5) : null,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(2, 2),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        const StrokeText(
          text: "グレー×全身",
          strokeWidth: 3,
          strokeColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF573F1B),
          ),
          shadows: [
            Shadow(
              blurRadius: 2,
              color: Colors.black,
              offset: Offset(1, 1),
            )
          ],
        )
      ],
    );
  }
}