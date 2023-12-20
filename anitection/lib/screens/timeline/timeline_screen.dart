import 'package:anitection/components/animal_pad_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineScreen extends ConsumerStatefulWidget {
  const TimelineScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return TimelineScreenState();
  }
}

class TimelineScreenState extends ConsumerState<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E0),
      body: Stack(
        children: [
          const AnimalPadBackground(),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
            children: const [
              TimelineCard(),
            ],
          )
        ],
      ),
    );
  }
}

class TimelineCard extends StatelessWidget {
  const TimelineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                      "https://img01.shiga-saku.net/usr/s/a/p/sapca/IMG_3912.jpg"),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "あにまる保護施設",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF444444),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Text("明日は休肝日ですので、わんちゃんねこちゃんとの面談の予約は受け付けておりません🙇\nご了承ください。"),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                      size: 24,
                    )),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.chat,
                    color: Colors.grey,
                    size: 24,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
