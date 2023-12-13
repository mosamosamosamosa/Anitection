import 'package:flutter/material.dart';

typedef OnSelectedTabItem = Function(TabType);

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView(
      {super.key, required this.selectedTab, required this.onSelectedTabItem});

  final TabType selectedTab;
  final OnSelectedTabItem onSelectedTabItem;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    const frillWidth = 55.0;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        for (int i = 0; i < (width / 55); i++)
          Positioned(
            left: frillWidth * i,
            top: -frillWidth * 0.40,
            child: Container(
              width: frillWidth,
              height: frillWidth,
              decoration: BoxDecoration(
                color: const Color(0xFFC3EB89),
                borderRadius: BorderRadius.circular(100),
                // shadow
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x40000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        Container(
          color: const Color(0xFFC3EB89),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  onSelectedTabItem(TabType.home);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.home,
                      color: selectedTab == TabType.home
                          ? const Color(0xffffb001)
                          : Colors.white,
                      size: 32,
                    ),
                    Text(
                      "ホーム",
                      style: TextStyle(
                        color: selectedTab == TabType.home
                            ? const Color(0xffffb001)
                            : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  onSelectedTabItem(TabType.chat);
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.chat_bubble,
                      color: selectedTab == TabType.chat
                          ? const Color(0xffffb001)
                          : Colors.white,
                      size: 32,
                    ),
                    Text(
                      "チャット",
                      style: TextStyle(
                        color: selectedTab == TabType.chat
                            ? const Color(0xffffb001)
                            : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  onSelectedTabItem(TabType.timeline);
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      color: selectedTab == TabType.timeline
                          ? const Color(0xffffb001)
                          : Colors.white,
                      size: 32,
                    ),
                    Text(
                      "タイムライン",
                      style: TextStyle(
                        color: selectedTab == TabType.timeline
                            ? const Color(0xffffb001)
                            : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  onSelectedTabItem(TabType.point);
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.point_of_sale_sharp,
                      color: selectedTab == TabType.point
                          ? const Color(0xffffb001)
                          : Colors.white,
                      size: 32,
                    ),
                    Text(
                      "ポイント",
                      style: TextStyle(
                        color: selectedTab == TabType.point
                            ? const Color(0xffffb001)
                            : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

enum TabType {
  home,
  chat,
  timeline,
  point,
}
