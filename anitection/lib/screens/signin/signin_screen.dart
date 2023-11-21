
import 'package:anitection/components/animal_pad_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUpScreen"),
      ),
      body: Stack(
        children: [
          AnimalPadBackground(),
          Form(child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "メールアドレス",
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "パスワード",
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("ログイン"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("新規登録"),
              ),
            ],
          )),
        ],
      ),
    );
  }
}