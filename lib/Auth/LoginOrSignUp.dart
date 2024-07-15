import 'package:attendance_mangement_system/Screens/SignUp_Screen.dart';
import 'package:flutter/material.dart';

import '../Screens/Login_Screen.dart';
class LoginOrSignUp extends StatefulWidget {
  const LoginOrSignUp({super.key});

  @override
  State<LoginOrSignUp> createState() => _LoginOrSignUpState();
}

class _LoginOrSignUpState extends State<LoginOrSignUp> {
  bool showLoginPage = true;
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        onTap: togglePages,
      );
    } else {
      return SignUpScreen(
        onTap: togglePages,
      );
    }
  }
}
