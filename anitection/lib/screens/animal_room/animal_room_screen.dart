import 'package:anitection/components/stroke_text.dart';
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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animal Room"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
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
                      height: size.height * 0.9,
                    ));
              },
            );
          },
          child: const Text("Button"),
        ),
      ),
    );
  }
}

class AnimalRoomProfileDialog extends StatelessWidget {
  const AnimalRoomProfileDialog({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border(
            top: BorderSide(
              width: 5,
              color: Color(0xFFC3EB89),
            ),
            left: BorderSide(
              width: 5,
              color: Color(0xFFC3EB89),
            ),
            right: BorderSide(
              width: 5,
              color: Color(0xFFC3EB89),
            ),
            bottom: BorderSide(
              width: 0,
              color: Color(0xFFC3EB89),
            ),
          )),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: -80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                      color: const Color(0xFFC3EB89),
                      width: 5,
                    ),
                  ),
                ),
                // circle image
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "https://p.potaufeu.asahi.com/9d94-p/picture/27141331/7f594b52c0696519598b63ac8162e3ff.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 45),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "茶トラ猫",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF444444),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "(3)",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF444444),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "♂",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF444444),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          "人懐っこい",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF444444),
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      "/",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFC3EB89),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Row(
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
                            text: "すきなもの",
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                            textColor: Color(0xFF444444),
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        // ねこじゃらし
                        const Text(
                          "ねこじゃらし",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF444444),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "人懐っこい3歳の男の子です。人懐っこい3歳の男の子です。人懐っこい3歳の男の子です。人懐っこい3歳の男の子です。人懐っこい3歳の男の子です。",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF444444),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const AnimalRoomProfileDialogDivider(),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                  ),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: [
                      for (int i = 0; i < 9; i++)
                        Container(
                          color: Colors.black26,
                        ),
                    ],
                  ),
                )
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AnimalRoomProfileDialogDivider extends StatelessWidget {
  const AnimalRoomProfileDialogDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              height: 2,
              thickness: 2,
              color: Color(0xFFC3EB89),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, 4),
          child: Transform.rotate(
            angle: 18,
            child: SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                "assets/svg/img_animal_pad.svg",
                colorFilter:
                    const ColorFilter.mode(Color(0xFFC3EB89), BlendMode.srcIn),
              ),
            ),
          ),
        ),
        Transform.rotate(
          angle: -18,
          child: SizedBox(
            width: 16,
            height: 16,
            child: SvgPicture.asset(
              "assets/svg/img_animal_pad.svg",
              colorFilter:
                  const ColorFilter.mode(Color(0xFFC3EB89), BlendMode.srcIn),
            ),
          ),
        ),
        const Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              height: 2,
              thickness: 2,
              color: Color(0xFFC3EB89),
            ),
          ),
        ),
      ],
    );
  }
}
