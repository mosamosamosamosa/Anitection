import 'package:anitection/layout/auth_guard_layout.dart';
import 'package:anitection/providers/auth_controller.dart';
import 'package:anitection/screens/animal_room/bottom_navigation.dart';
import 'package:anitection/screens/chat_list/chat_list_screen.dart';
import 'package:anitection/screens/home/home_screen.dart';
import 'package:anitection/screens/timeline/timeline_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainNavScreen extends ConsumerStatefulWidget {
  const MainNavScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MainNavScreenState();
  }
}

class MainNavScreenState extends ConsumerState<MainNavScreen> {
  TabType selectedTab = TabType.home;

  @override
  Widget build(BuildContext context) {
    return AuthGuardLayout(
      asyncValue: ref.watch(authControllerProvider),
      child: Scaffold(
        body: IndexedStack(
          index: selectedTab.index,
          children: [
            const HomeScreen(),
            const ChatListScreen(),
            const TimelineScreen(),
            Container(
              color: Colors.yellow,
              child: SingleChildScrollView(
                child: Text(
                  [for(int i = 0; i < 9999; i++) "デザインどこですか？"].join(),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationView(
          selectedTab: selectedTab,
          onSelectedTabItem: (tab) {
            setState(() {
              selectedTab = tab;
            });
          },
        ),
      ),
    );
  }
}
