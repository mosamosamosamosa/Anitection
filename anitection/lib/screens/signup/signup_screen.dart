import 'dart:developer';

import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/normal_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/providers/auth_controller.dart';
import 'package:anitection/screens/signin/signin_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E0),
      body: Stack(
        children: [
          const AnimalPadBackground(),
          SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Column(
                      children: [
                        StrokeText(
                          text: "Animal Protection",
                          strokeColor: Colors.white,
                          strokeWidth: 4,
                          textStyle: GoogleFonts.zenMaruGothic(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF573F1B),
                          ),
                          shadows: const [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(2, 2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        Image.asset("assets/images/anitection_dummy_logo.png"),
                      ],
                    ),
                    AuthInputFormArea(
                        emailController: _emailController,
                        passwordController: _passwordController,
                    ),
                    Column(
                      children: [
                        NormalButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('入力に誤りがあります')),
                              );
                            }
                            onSubmit();
                          },
                          width: 219,
                          height: 64,
                          maxElevation: 8,
                          child: const StrokeText(
                            text: "登録",
                            textColor: Color(0xFF573F1B),
                            strokeColor: Colors.white,
                            strokeWidth: 2,
                            shadows: [
                              Shadow(
                                color: Color(0xFF573F1B),
                                offset: Offset(2, 2),
                                blurRadius: 10,
                              ),
                            ],
                            textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily:
                                  GoogleFonts.zenMaruGothic().fontFamily,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              const TextSpan(
                                text: "アカウントをお持ちの方は",
                                style: TextStyle(color: Color(0xFF573F1B)),
                              ),
                              TextSpan(
                                text: "こちら",
                                style: const TextStyle(
                                  color: Color(0xFFFF635A),
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInScreen(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSubmit() async {
    ref.read(authControllerProvider.notifier).signUp(email: _emailController.text, password: _passwordController.text).then((value) {
      log("登録成功");
      Navigator.of(context).pop();
    }).catchError((e, st) {
      log("登録エラー", error: e, stackTrace: st);
    });
  }
}
