
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
        backgroundColor: const Color(0xFFC3EB89),
        title: const Padding(
          padding: EdgeInsets.all(16),
          child: Text("あにまる保護施設", style: TextStyle(
            fontSize: 24
          ),),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child:
          NavUpButton(
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
          Center(
            child: Text('Hello, Flutter!'),
          ),
        ],
      ),

    );
  }
}
