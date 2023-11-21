import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/normal_button.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/screens/signup/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SignInScreen> {
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const Text("ここにロゴが入る"),
                    AuthInputFormArea(emailController: _emailController, passwordController: _passwordController),
                    Column(
                      children: [
                        NormalButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('入力に誤りがあります')),
                              );
                            }
                          },
                          width: 219,
                          height: 64,
                          maxElevation: 8,
                          child: const StrokeText(
                            text: "ログイン",
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
                                text: "アカウントをお持ちではない方は",
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
                                        const SignUpScreen(),
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
      )
    );
  }
}

class AuthInputFormArea extends StatelessWidget {
  const AuthInputFormArea({super.key, required this.emailController, required this.passwordController});
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "E-Mail",
              fillColor: Color(0xFFF5EED6),
              labelStyle: TextStyle(
                color: Color(0x664B4B4B),
                fontWeight: FontWeight.bold,
              ),
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide.none
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide.none
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                borderSide: BorderSide(
                  color: Color(0xFFA9E94C),
                  width: 3,
                ),
              ),
            ),
          ),

        ),
        const SizedBox(height: 16,),
        Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              labelText: "Password",
              fillColor: Color(0xFFF5EED6),
              labelStyle: TextStyle(
                color: Color(0x664B4B4B),
                fontWeight: FontWeight.bold,
              ),
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide.none
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide.none
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                borderSide: BorderSide(
                  color: Color(0xFFA9E94C),
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}