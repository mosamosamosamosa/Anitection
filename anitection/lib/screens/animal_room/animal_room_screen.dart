import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                  )
                );
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
            top: -60,
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
          const Column(
            children: [
              SizedBox(height: 65),
              Row(
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
                  SizedBox(width: 8,),
                  Text(
                    "(3)",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF444444),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8,),
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
            ],
          ),
        ],
      ),
    );
  }
}