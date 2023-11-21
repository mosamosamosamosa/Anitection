import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/normal_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/screens/signin/signin_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimalPadBackground(),
          SafeArea(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "メールアドレス",
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: "パスワード",
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('入力に誤りがあります')),
                          );
                        }
                      },
                      child: const Text("登録"),
                    ),
                    NormalButton(
                      onPressed: () {},
                      width: 219,
                      height: 64,
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
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: GoogleFonts.zenMaruGothic().fontFamily,
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
                                    builder: (context) => const SignInScreen(),
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
          )),
        ],
      ),
    );
  }
}
