
import 'package:anitection/screens/initial_startup/initial_startup_screen.dart';
import 'package:flutter/material.dart';

class AuthGuardLayout extends StatelessWidget {
  const AuthGuardLayout({super.key, required this.child, required this.isLoggedIn});
  final Widget child;
  final bool isLoggedIn;


  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? child : const InitialStartupScreen();
  }
}
