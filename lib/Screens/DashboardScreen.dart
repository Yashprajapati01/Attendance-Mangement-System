import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/Auth_Services/auth_service.dart';
import '../Auth/LoginOrSignUp.dart';
import 'Login_Screen.dart';
class DashboardScreen extends StatelessWidget {
   DashboardScreen({super.key});
  final AuthService _authService = AuthService();

  void _logout(BuildContext context) async {
    await _authService.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.remove('email');
    // await prefs.remove('password');
    // await prefs.setBool('remember_me', false);
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => LoginScreen(onTap: () {  },)),
    // );
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginOrSignUp()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body:  Center(
        child: Image.asset(
          'images/att.png',
          height: 40,
        ),
      ),
    );
  }
}
