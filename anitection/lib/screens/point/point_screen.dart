import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PointScreen extends ConsumerStatefulWidget {
  const PointScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return PointScreenState();
  }
}

class PointScreenState extends ConsumerState<PointScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC3EB89),
        elevation: 0,
        title: const StrokeText(
          text: "ポイント",
          strokeColor: Colors.white,
          textColor: Color(0xFF573F1B),
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: "Anek Bangle",
          ),
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(0, 0),
              blurRadius: 10,
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const AnimalPadBackground(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/ic_point.svg",
                      width: 42,
                      height: 42,
                    ),
                    const SizedBox(width: 8),
                    const StrokeText(
                      text: "10,000",
                      strokeColor: Colors.white,
                      textColor: Color(0xFF573F1B),
                      textStyle: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Anek Bangle",
                      ),
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(0, 0),
                          blurRadius: 10,
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC6DEE8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const StrokeText(
                          text: "ポイント購入",
                          strokeColor: Colors.white,
                          textColor: Color(0xFF573F1B),
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFDB1D),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const StrokeText(
                          text: "ポイントGET",
                          strokeColor: Colors.white,
                          textColor: Color(0xFF573F1B),
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: StrokeText(
                    text: "ポイント履歴",
                    strokeColor: Colors.white,
                    textColor: const Color(0xFF573F1B),
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0, 0),
                        blurRadius: 10,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(2, 2),
                        )
                      ],
                    ),
                    child: ListView(
                      children: [
                        SizedBox(height: 16),
                        const PointHistoryItem(date: "2023年11月24日", institutionName: "あにまる保護施設", point: "200"),
                        Divider(),
                        const PointHistoryItem(date: "2023年5月23日", institutionName: "あにまる保護施設", point: "140"),
                        Divider(),
                        const PointHistoryItem(date: "2023年5月23日", institutionName: "あにまる保護施設", point: "240"),
                        Divider(),
                        const PointHistoryItem(date: "2023年5月23日", institutionName: "あにまる保護施設", point: "1200"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PointHistoryItem extends StatelessWidget {
  const PointHistoryItem({Key? key, required this.date, required this.institutionName, required this.point}) : super(key: key);
  final String date;
  final String institutionName;
  final String point;

  @override
  Widget build(BuildContext context) {
    return                         Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF573F1B),
                ),
              ),
              Text(
                institutionName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF573F1B),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/ic_point.svg",
                width: 42,
                height: 42,
              ),
              const SizedBox(width: 8),
              StrokeText(
                text: point,
                strokeColor: Colors.white,
                textColor: Color(0xFF573F1B),
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Anek Bangle",
                ),
                shadows: const [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}