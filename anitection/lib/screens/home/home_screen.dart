import 'package:anitection/components/animal_pad_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            color: Color(0xFFC3EB89),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        width: 24,
                        height: 18,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/ic_calendar.svg",
                          width: 50,
                          height: 50,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFF94CD68),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          child: const Text(
                            "10月30日",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/ic_setting.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: Stack(
        children: [
          const AnimalPadBackground(),
          Column(
            children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.width * 0.10512820512),
                painter: TrianglePainter(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xFFC3EB89)
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(size.width / 2, size.height); // 上の中心点
    path.lineTo(size.width, 0); // 右下の点
    path.lineTo(0, 0); // 左下の点
    path.close(); // パスを閉じる

    // 影のスタイルを定義
    // var shadowPaint = Paint()
    //   ..color = Colors.black.withOpacity(0.1) // 影の色と透明度
    //   ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10); // ぼかしのスタイルと度合い

    // 影を描画
    canvas.drawShadow(path, Colors.black.withOpacity(0.5), 4.0, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
