import 'package:anitection/components/animal_pad_background.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text("SignUpScreen"),
      ),
      body: Stack(
        children: [
          const AnimalPadBackground(),
          Form(
            key: _formKey,
            child: Column(
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('入力に誤りがあります')),
                      );
                    }

                  },
                  child: const Text("ログイン"),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("新規登録"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
