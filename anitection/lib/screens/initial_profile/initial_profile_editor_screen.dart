import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitialProfileEditorScreen extends ConsumerStatefulWidget {
  const InitialProfileEditorScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return InitialProfileEditorScreenState();
  }
}

class InitialProfileEditorScreenState
    extends ConsumerState<InitialProfileEditorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC3EB89),
        title: const StrokeText(
          text: "プロフィール登録",
          strokeWidth: 4,
          strokeColor: Colors.white,
          textStyle: TextStyle(
              color: Color(0xFF573F1B),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          AnimalPadBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Stack(
                children: [

                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
