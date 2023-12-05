
import 'package:anitection/models/user/user.dart';
import 'package:anitection/screens/initial_startup/initial_startup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGuardLayout extends StatelessWidget {
  const AuthGuardLayout({super.key, required this.child, required this.asyncValue});
  final Widget child;
  final AsyncValue<User> asyncValue;


  @override
  Widget build(BuildContext context) {
    return switch(asyncValue) {
      // ignore: unused_local_variable
      AsyncData(:final value) => child,
      // ignore: unused_local_variable
      AsyncError(:final error) => const InitialStartupScreen(),
      _ => const Center(child: CircularProgressIndicator(),)
    };
  }
}
