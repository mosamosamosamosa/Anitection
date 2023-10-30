import 'package:anitection/components/nav_up_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/animal_pad_background.dart';

class InstitutionScreen extends ConsumerStatefulWidget {
  const InstitutionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return InstitutionScreenState();
  }
}

class InstitutionScreenState extends ConsumerState<InstitutionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E0),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFC3EB89),
        title: const Padding(
          padding: EdgeInsets.all(16),
          child: StrokeText(
            text: "あにまる保護施設",
            textStyle: TextStyle(fontSize: 24),
            strokeWidth: 4,
            strokeColor: Colors.white,
            textColor: Color(0xFF573F1B),
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: NavUpButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          AnimalPadBackground(),
          // ここに他のウィジェットを追加
          SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InstitutionImage(
                  url:
                  "https://img.furusato-tax.jp/img/x/original/feature/form/details/20211129/gpfd_107bfa9e0ad3c76c4afea5461d79acf480140bda.jpg",
                ),
                const SizedBox(height: 32,),
                const InstitutionLabel(label: "所在地"),
                const SizedBox(height: 8,),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                          "大阪府大阪市旭区高殿2-21-11-5",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {

                        },
                        child: const Icon(
                            Icons.copy,
                          color: Color(0xFFC3EB89),
                        ),
                      )
                    ],
                  ),
                ),


              ],
            ),
          ))
        ],
      ),
    );
  }
}

class InstitutionImage extends StatelessWidget {
  const InstitutionImage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFFC3EB89),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.network(
          url,
        ),
      ),
    );
  }
}

class InstitutionLabel extends StatelessWidget {
  const InstitutionLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFC3EB89),
        borderRadius: BorderRadius.circular(6),
      ),
      child: StrokeText(
        text: label,
        textColor: const Color(0xFF444444),
        strokeColor: Colors.white,
        strokeWidth: 4,
      ),
    );
  }
}

class StrokeText extends StatelessWidget {
  final String text;
  final double strokeWidth;
  final Color textColor;
  final Color strokeColor;
  final TextStyle? textStyle;
  final List<Shadow>? shadows;

  const StrokeText(
      {Key? key,
      required this.text,
      this.strokeWidth = 1,
      this.strokeColor = Colors.black,
      this.textColor = Colors.white,
      this.textStyle,
      this.shadows})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
            shadows: shadows,
          ).merge(textStyle),
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
          ).merge(textStyle),
        ),
      ],
    );
  }
}
