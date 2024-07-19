// // import 'package:attendance_mangement_system/Auth/LoginOrSignUp.dart';
// // import 'package:attendance_mangement_system/Screens/DashboardScreen.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// // class AuthGate extends StatelessWidget {
// //   const AuthGate({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: StreamBuilder(
// //           stream: FirebaseAuth.instance.authStateChanges(),
// //           builder: (context, snapshot){
// //             //user is logged or not
// //             if(snapshot.hasData){
// //               return DashboardScreen();
// //             }
// //             else {
// //               return const LoginOrSignUp();
// //             }
// //           }
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:attendance_mangement_system/Auth/LoginOrSignUp.dart';
// import 'package:attendance_mangement_system/Dashboard%20Admin/DashboardScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthGate extends StatelessWidget {
//   const AuthGate({Key? key}) : super(key: key);
//
//   Future<bool> _isRememberMeChecked() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('remember_me') ?? false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: _isRememberMeChecked(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasData && snapshot.data == true) {
//           User? user = FirebaseAuth.instance.currentUser;
//           if (user != null) {
//             return DashboardScreen(userId: user.uid,);
//           } else {
//             return LoginOrSignUp();
//           }
//         } else {
//           return LoginOrSignUp();
//         }
//       },
//     );
//   }
// }
import 'package:attendance_mangement_system/Auth/LoginOrSignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashboard Admin/DashboardScreen.dart';
import '../Dashboard Professor/ProfessorDashboard.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  Future<bool> _isRememberMeChecked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('remember_me') ?? false;
  }

  Future<String?> _getUserType(User? user) async {
    if (user == null) return null;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return snapshot['userType'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isRememberMeChecked(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimationWidget.inkDrop(color: Colors.white70, size: 20);
        } else if (snapshot.hasData && snapshot.data == true) {
          User? user = FirebaseAuth.instance.currentUser;
          return FutureBuilder<String?>(
            future: _getUserType(user),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingAnimationWidget.inkDrop(color: Colors.white70, size: 20);
              } else if (snapshot.hasData) {
                String? userType = snapshot.data;
                if (userType == 'Admin') {
                  return DashboardScreen(userId: user!.uid);
                } else if (userType == 'Professor') {
                  return ProfessorDashboardScreen();
                } else {
                  return const LoginOrSignUp();
                }
              } else {
                return const LoginOrSignUp();
              }
            },
          );
        } else {
          return LoginOrSignUp();
        }
      },
    );
  }
}
