import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/normal_button.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _liveController = TextEditingController();

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
          const AnimalPadBackground(),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: InitialProfileEditorScreenAvatarPreview(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const NicknameHeader(),
                      const SizedBox(height: 8),
                      Material(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: _nicknameController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8,
                            ),
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Color(0x664B4B4B),
                              fontWeight: FontWeight.bold,
                            ),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const LiveHeader(),
                      const SizedBox(height: 8),
                      Material(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: _liveController,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Color(0x664B4B4B),
                              fontWeight: FontWeight.bold,
                            ),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const InstallReasonHeader(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // radio
                          RadioSelection(
                            title: "保護犬猫を引き取りたい",
                            onChanged: (v) {},
                            groupValue: "a",
                            value: "a",
                          ),
                          RadioSelection(
                            title: "保護犬猫への支援に興味がある",
                            onChanged: (v) {},
                            groupValue: "a",
                            value: "b",
                          ),
                          RadioSelection(
                            title: "アプリを体験してみたい",
                            onChanged: (v) {},
                            groupValue: "a",
                            value: "c",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CancelButton(onPressed: () {}),
                      const SizedBox(width: 16),
                      SubmitButton(onPressed: () {})
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return NormalButton(
      width: 160,
      height: 56,
      surfaceColor: const Color(0xFFC7C7C7),
      sideColor: const Color(0xFF888888),
      maxElevation: 6,
      onPressed: onPressed,
      child: const StrokeText(
        text: "キャンセル",
        strokeWidth: 4,
        strokeColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF573F1B),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return NormalButton(
      width: 160,
      height: 56,
      maxElevation: 6,
      onPressed: onPressed,
      child: const StrokeText(
        text: "登録",
        strokeWidth: 4,
        strokeColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF573F1B),
        ),
      ),
    );
  }
}

class InitialProfileEditorScreenAvatarPreview extends StatelessWidget {
  const InitialProfileEditorScreenAvatarPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFFFB001),
              width: 3,
            ),
            image: const DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/img_empty_avatar.png"),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFB001),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class RequireLabel extends StatelessWidget {
  const RequireLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xFFFF635A),
      ),
      child: const Text(
        "必須",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class InstallReasonHeader extends StatelessWidget {
  const InstallReasonHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        StrokeText(
          text: "アプリを入れた理由",
          strokeWidth: 4,
          strokeColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF573F1B),
          ),
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        SizedBox(width: 8),
        RequireLabel(),
      ],
    );
  }
}

class LiveHeader extends StatelessWidget {
  const LiveHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        StrokeText(
          text: "お住まいの地域",
          strokeWidth: 4,
          strokeColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF573F1B),
          ),
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        SizedBox(width: 8),
        RequireLabel(),
      ],
    );
  }
}

class NicknameHeader extends StatelessWidget {
  const NicknameHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        StrokeText(
          text: "ニックネーム",
          strokeWidth: 4,
          strokeColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF573F1B),
          ),
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        SizedBox(width: 8),
        RequireLabel(),
      ],
    );
  }
}

class RadioSelection<T> extends StatelessWidget {
  const RadioSelection(
      {super.key,
      required this.title,
      required this.onChanged,
      required this.groupValue,
      required this.value});

  final String title;
  final ValueChanged<T?>? onChanged;
  final T? groupValue;
  final T value;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: const Color(0xFFFFB001)),
      child: RadioListTile(
        activeColor: const Color(0xFFFFB001),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        contentPadding: EdgeInsets.zero,
        title: StrokeText(
          text: title,
          strokeWidth: 4,
          strokeColor: Colors.white,
          textStyle: const TextStyle(color: Color(0xFF573F1B), fontSize: 18),
        ),
      ),
    );
  }
}
