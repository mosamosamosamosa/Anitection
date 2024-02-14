import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/institution_title.dart';
import 'package:anitection/components/nav_up_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/screens/shop/shop_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> foodName = ['キャットフード', 'ねこ缶', 'まぐろのお刺身'];
    List<String> toyName = ['ねこじゃらし', '毛糸玉', 'おさかなのもふもふ'];

    List<String> food = [
      'img_karikari.png',
      'img_nekocan.png',
      'img_maguro.png'
    ];

    List<String> toy = ['img_nekojarashi.png', 'img_keito.png', 'img_fish.png'];

    return Scaffold(
        backgroundColor: const Color(0xFFFFF8E0),
        body: Stack(children: [
          AnimalPadBackground(),
          Padding(
            padding: const EdgeInsets.only(top: 160),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/ic_point.svg",
                      width: 42,
                      height: 42,
                    ),
                    const SizedBox(width: 10),
                    StrokeText(
                      text: "10,000",
                      strokeColor: Colors.white,
                      strokeWidth: 8,
                      textColor: Color(0xFF573F1B),
                      textStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Anek Bangle",
                      ),
                      shadows: const [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  children: [
                    ShopCard(
                      list: food,
                      kind: 'food',
                      nameList: foodName,
                    ),
                    SizedBox(height: 22),
                    ShopCard(
                      list: toy,
                      kind: 'toy',
                      nameList: toyName,
                    )
                  ],
                ),
              ],
            ),
          ),
          Appbar()
        ]));
  }
}

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0XFFC3EB89),
            boxShadow: [
              BoxShadow(
                color: Colors.black26, //色
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          height: 130,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(top: 36),
            child: Center(child: InstitutionTitle(title: "ショップ")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 64, left: 10),
          child: NavUpButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 114),
          child: Image.asset('assets/images/dot_border.png'),
        )
      ],
    );
  }
}

class ShopCard extends StatelessWidget {
  ShopCard(
      {super.key,
      required this.list,
      required this.kind,
      required this.nameList});

  List<String> list;
  List<String> nameList;

  String kind;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 340,
          height: 248,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26, //色
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/${kind}_back_icon.png'),
              GridView.builder(
                padding: EdgeInsets.all(18),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // グリッドの列数
                ),
                itemBuilder: // グリッドに表示するアイテムの数
                    (BuildContext context, int index) {
                  return index < list.length
                      ? GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ShopDialog(
                                    name: nameList[index],
                                    image: list[index],
                                  );
                                });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 50,
                                child:
                                    Image.asset('assets/images/${list[index]}'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/ic_point.svg",
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 5),
                                  StrokeText(
                                    text: "200",
                                    strokeColor: Colors.white,
                                    strokeWidth: 4,
                                    textColor: Color(0xFF573F1B),
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Anek Bangle",
                                    ),
                                    shadows: const [
                                      Shadow(
                                        color: Colors.black,
                                        offset: Offset(0, 4),
                                        blurRadius: 10,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Image.asset('assets/images/q_box.png');
                },
                itemCount: 12,
              ),
            ],
          ),
        ),
        Image.asset('assets/images/${kind}_tag.png')
      ],
    );
  }
}
