
import 'dart:math';

import 'package:anitection/screens/animal_room/animal_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef OnMenuSelectedListener = void Function(SelectedTab selectedTab);
class AnimalRoomBottomNavMenu extends StatelessWidget {
  const AnimalRoomBottomNavMenu({super.key, this.selectedTab = SelectedTab.normal, required this.onMenuSelectedListener});
  final SelectedTab selectedTab;
  final OnMenuSelectedListener onMenuSelectedListener;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemSize = min((width - 80) / 4 - ((width - 80) / 4 * 0.1), 70.0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          width: 80,
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                onMenuSelectedListener(SelectedTab.food);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: itemSize,
                    height: itemSize,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFCF3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFC3EB89),
                        width: 3,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/svg/ic_dinner.svg",
                    width: itemSize * 0.57,
                    height: itemSize * 0.57,
                  ),
                ],
              ),
            ),
            Container(
              width: 3,
              height: selectedTab == SelectedTab.food ? 22 : 44,
              color: const Color(0xFFC3EB89),
            )
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                onMenuSelectedListener(SelectedTab.stroll);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: itemSize,
                    height: itemSize,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFCF3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFFB001),
                        width: 3,
                      ),
                    ),
                  ),
                  SvgPicture.asset("assets/svg/ic_tree.svg",
                      width: itemSize * 0.57, height: itemSize * 0.57),
                ],
              ),
            ),
            Container(
              width: 3,
              height: selectedTab == SelectedTab.stroll ? 22 : 44,
              color: const Color(0xFFFFB001),
            )
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                onMenuSelectedListener(SelectedTab.clean);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: itemSize,
                    height: itemSize,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFCF3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFC6DEE8),
                        width: 3,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/svg/ic_bucket.svg",
                    width: itemSize * 0.57,
                    height: itemSize * 0.57,
                  ),
                ],
              ),
            ),
            Container(
              width: 3,
              height: selectedTab == SelectedTab.clean ? 22 : 44,
              color: const Color(0xFFC6DEE8),
            )
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                onMenuSelectedListener(SelectedTab.play);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: itemSize,
                    height: itemSize,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFCF3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFFDB1D),
                        width: 3,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/svg/ic_stop_hand.svg",
                    width: itemSize * 0.57,
                    height: itemSize * 0.57,
                  ),
                ],
              ),
            ),
            Container(
              width: 3,
              height: selectedTab == SelectedTab.play ? 22 : 44,
              color: const Color(0xFFFFDB1D),
            )
          ],
        )
      ],
    );
  }
}
