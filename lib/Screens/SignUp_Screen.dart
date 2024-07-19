// import 'package:attendance_mangement_system/components/Button.dart';
// import 'package:attendance_mangement_system/components/MyTextInputField.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// import '../Auth/Auth_Services/auth_service.dart';
// import 'Login_Screen.dart';
// class SignUpScreen extends StatefulWidget {
//   final void Function()? onTap;
//   const SignUpScreen({super.key , required this.onTap});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController emailController = new TextEditingController();
//   TextEditingController passController = new TextEditingController();
//   TextEditingController userTypeController = new TextEditingController();
//
//   final AuthService _authService = AuthService();
//
//   void signup(BuildContext context) async {
//     User? user = await _authService.signUpWithEmailAndPassword(
//       emailController.text,
//       passController.text,
//       userTypeController.text,
//     );
//     if (user != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen(onTap: () {  },)),
//       );
//     } else {
//       print('Signup failed');
//     }
//   }
//
//
//
//   bool? ischecked = false;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(25.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox( height : MediaQuery.of(context).size.width * 0.1), // Example: 10% of screen width)
//                 // logo
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'images/att.png',
//                       height: 40,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("MANAGEMENT",
//                       style: TextStyle(
//                           fontFamily: 'Gotham',
//                           color: Colors.grey.shade300,
//                           fontSize: 20
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("SYSTEM",
//                       style: TextStyle(
//                           fontFamily: 'Gotham',
//                           color: Colors.grey.shade300,
//                           fontSize: 20
//                       ),
//                     ),
//                   ],
//                 ),
//                 // logo ends
//                 SizedBox(height: MediaQuery.of(context).size.width * 0.07),
//                 Text("Let's create an account for you",
//                   style: TextStyle(
//                       fontFamily: 'Gotham book',
//                       color: Colors.grey.shade300,
//                       fontSize: 15
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.width * 0.06),
//                 MyTextField(hintText: "Roll Number / Email",
//                     controller: emailController,
//                     tf: false,
//                     focusNode: null
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.width * 0.06),
//                 MyTextField(hintText: "Password",
//                     controller: passController,
//                     tf: true,
//                     focusNode: null
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.width * 0.03),
//                 MyTextField(hintText: "UserType : Admin/Professor/Student",
//                     controller: userTypeController,
//                     tf: false,
//                     focusNode: null
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.width * 0.1),
//                 MyButton(txt: "Sign Up" ,
//                   onTap: () => signup(context),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.width * 0.03),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Already a member ?",
//                       style: TextStyle(
//                           fontFamily: 'Gotham book',
//                           color: Colors.grey.shade300,
//                           fontSize: 12
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: widget.onTap,
//                       child: Text(" Login Now",
//                         style: TextStyle(
//                             fontFamily: 'Gotham',
//                             color: Colors.grey.shade300,
//                             fontSize: 12
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:attendance_mangement_system/components/Button.dart';
import 'package:attendance_mangement_system/components/MyTextInputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Auth/Auth_Services/auth_service.dart';
import 'Login_Screen.dart';

class SignUpScreen extends StatefulWidget {
  final void Function()? onTap;
  const SignUpScreen({super.key , required this.onTap});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  String? selectedUserType;
  final AuthService _authService = AuthService();

  void signup(BuildContext context) async {
    User? user = await _authService.signUpWithEmailAndPassword(
      emailController.text,
      passController.text,
      selectedUserType ?? '',
    );
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen(onTap: () {  },)),
      );
    } else {
      print('Signup failed');
    }
  }

  bool? ischecked = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width * 0.1), // Example: 10% of screen width)
                // logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/att.png',
                      height: 40,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("MANAGEMENT",
                      style: TextStyle(
                          fontFamily: 'Gotham',
                          color: Colors.grey.shade300,
                          fontSize: 20
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("SYSTEM",
                      style: TextStyle(
                          fontFamily: 'Gotham',
                          color: Colors.grey.shade300,
                          fontSize: 20
                      ),
                    ),
                  ],
                ),
                // logo ends
                SizedBox(height: MediaQuery.of(context).size.width * 0.07),
                Text("Let's create an account for you",
                  style: TextStyle(
                      fontFamily: 'Gotham book',
                      color: Colors.grey.shade300,
                      fontSize: 15
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                MyTextField(
                    hintText: "Roll Number / Email",
                    controller: emailController,
                    tf: false,
                    focusNode: null
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                MyTextField(
                    hintText: "Password",
                    controller: passController,
                    tf: true,
                    focusNode: null
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                    ),
                    fillColor: Theme.of(context).colorScheme.secondary,
                    filled: true,
                    hintText: "Select UserType",
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  value: selectedUserType,
                  items: ['Admin', 'Professor', 'Student']
                      .map((userType) => DropdownMenuItem(
                    value: userType,
                    child: Text(userType),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedUserType = value;
                    });
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                MyButton(txt: "Sign Up",
                  onTap: () => signup(context),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member ?",
                      style: TextStyle(
                          fontFamily: 'Gotham book',
                          color: Colors.grey.shade300,
                          fontSize: 12
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(" Login Now",
                        style: TextStyle(
                            fontFamily: 'Gotham',
                            color: Colors.grey.shade300,
                            fontSize: 12
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
