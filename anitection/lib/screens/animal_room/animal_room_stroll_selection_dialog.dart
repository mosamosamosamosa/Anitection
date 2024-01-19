
import 'package:anitection/components/normal_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:flutter/material.dart';

class StrollSelectionDialogLayout extends StatefulWidget {
  const StrollSelectionDialogLayout({super.key});

  @override
  State<StatefulWidget> createState() {
    return StrollSelectionDialogLayoutState();
  }
}
class StrollSelectionDialogLayoutState extends State<StrollSelectionDialogLayout> {

  StrollLocation selectedLocation = StrollLocation.park;

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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedLocation = StrollLocation.park;
                          });
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: width * aspect,
                          height: (width * aspect) * (90 / 120),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA6EAFF),
                            borderRadius: BorderRadius.circular(10),
                            border: selectedLocation == StrollLocation.park ? Border.all(
                              color: const Color(0xFFFF1515),
                              width: 2,
                            ) : null,
                          ),
                          child: Image.asset(
                            "assets/images/img_park.png",
                            fit: BoxFit.cover,
                            width: width * aspect,
                            height: (width * aspect) * (90 / 120),
                          ),
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedLocation = StrollLocation.amusementPark;
                          });
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: width * aspect,
                          height: (width * aspect) * (90 / 120),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: selectedLocation == StrollLocation.amusementPark ? Border.all(
                              color: const Color(0xFFFF1515),
                              width: 2,
                            ) : null,
                          ),
                          child: Image.asset(
                            "assets/images/img_amusement_park.png",
                            fit: BoxFit.cover,
                            width: width * aspect,
                            height: (width * aspect) * (90 / 120),
                          ),
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedLocation = StrollLocation.shoppingStreet;
                          });
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: width * aspect,
                          height: (width * aspect) * (90 / 120),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: selectedLocation == StrollLocation.shoppingStreet ? Border.all(
                              color: const Color(0xFFFF1515),
                              width: 2,
                            ) : null,
                          ),
                          child: Image.asset(
                            "assets/images/img_shopping_street.png",
                            fit: BoxFit.cover,
                            width: width * aspect,
                            height: (width * aspect) * (90 / 120),
                          ),
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedLocation = StrollLocation.seaside;
                          });
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: width * aspect,
                          height: (width * aspect) * (90 / 120),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: selectedLocation == StrollLocation.seaside ? Border.all(
                              color: const Color(0xFFFF1515),
                              width: 2,
                            ) : null,
                          ),
                          child: Image.asset(
                            "assets/images/img_seaside.png",
                            fit: BoxFit.cover,
                            width: width * aspect,
                            height: (width * aspect) * (90 / 120),
                          ),
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
                      Navigator.of(context).pop();
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
                      Navigator.of(context).pop(selectedLocation);
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

enum StrollLocation {
  park,
  amusementPark,
  shoppingStreet,
  seaside,
}