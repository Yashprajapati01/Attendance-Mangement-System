// import 'package:attendance_mangement_system/Auth/LoginOrSignUp.dart';
// import 'package:attendance_mangement_system/Screens/DashboardScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class AuthGate extends StatelessWidget {
//   const AuthGate({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot){
//             //user is logged or not
//             if(snapshot.hasData){
//               return DashboardScreen();
//             }
//             else {
//               return const LoginOrSignUp();
//             }
//           }
//       ),
//     );
//   }
// }


import 'package:attendance_mangement_system/Auth/LoginOrSignUp.dart';
import 'package:attendance_mangement_system/Screens/DashboardScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  Future<bool> _isRememberMeChecked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('remember_me') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isRememberMeChecked(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data == true) {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            return DashboardScreen();
          } else {
            return LoginOrSignUp();
          }
        } else {
          return LoginOrSignUp();
        }
      },
    );
  }
}
