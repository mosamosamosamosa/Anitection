import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/normal_button.dart';
import 'package:anitection/components/number_stepper.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/screens/initial_animal_filter/initial_cat_preference_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class InitialAnimalTypeSelectionTypeScreen extends ConsumerStatefulWidget {
  const InitialAnimalTypeSelectionTypeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return InitialAnimalTypeSelectionTypeState();
  }
}

class InitialAnimalTypeSelectionTypeState extends ConsumerState<InitialAnimalTypeSelectionTypeScreen> {

  AnimalType _selectedType = AnimalType.cat;

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
                      curStep: 1,
                      stepCompleteColor: const Color(0xFFC3EB89),
                      totalSteps: 3,
                      inactiveColor: const Color(0xFFD9D9D9),
                      currentStepColor: const Color(0xFFD9D9D9),
                      lineWidth: 6,
                    ),
                  ),
                  StrokeText(
                    text: "あなたの好きな動物\n教えてください",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedType = AnimalType.cat;
                          });
                        },
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _selectedType == AnimalType.cat ? const Color(0xFFFDE38B) : const Color(0xFFD9D9D9),
                            border: _selectedType == AnimalType.cat ? Border.all(color: const Color(0xFFFFB001), width: 2) : null,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Image.asset(
                            "assets/images/img_animal_type_as_cat.png",
                            width: 100,
                            height: 75,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedType = AnimalType.dog;
                          });
                        },
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _selectedType == AnimalType.dog ? const Color(0xFFFDE38B) : const Color(0xFFD9D9D9),
                            border: _selectedType == AnimalType.dog ? Border.all(color: const Color(0xFFFFB001), width: 2) : null,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Image.asset(
                            "assets/images/img_animal_type_as_dog.png",
                            width: 100,
                            height: 75,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [Container()],
                  ),
                  NormalButton(
                    width: 219,
                    height: 64,
                    onPressed: () {
                      switch(_selectedType) {
                        case AnimalType.cat:
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const InitialCatPreferenceSelectionScreen()));
                          break;
                        case AnimalType.dog:
                          break;
                      }
                    },
                    child: const StrokeText(
                      text: "次へ",
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
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

enum AnimalType {
  cat, dog
}