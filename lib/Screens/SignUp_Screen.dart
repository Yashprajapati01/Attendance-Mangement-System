import 'package:attendance_mangement_system/components/Button.dart';
import 'package:attendance_mangement_system/components/MyTextInputField.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
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
  TextEditingController userTypeController = new TextEditingController();

  final AuthService _authService = AuthService();

  void signup(BuildContext context) async {
    User? user = await _authService.signUpWithEmailAndPassword(
      emailController.text,
      passController.text,
      userTypeController.text,
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
                SizedBox( height : MediaQuery.of(context).size.width * 0.1), // Example: 10% of screen width)
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
                MyTextField(hintText: "Roll Number / Email",
                    controller: emailController,
                    tf: false,
                    focusNode: null
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                MyTextField(hintText: "Password",
                    controller: passController,
                    tf: true,
                    focusNode: null
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                //  DropdownMenu(dropdownMenuEntries: <DropdownMenuEntry<TextEditingController>>[
                //   DropdownMenuEntry(value: userType, label: 'Admin'),
                //    DropdownMenuEntry(value: userType, label: 'Professor'),
                //    DropdownMenuEntry(value: userType, label: 'Student'),
                // ]),
                // DropDownTextField(
                //   controller: userType,
                //   dropDownItemCount: 3,
                //   dropDownList: const [DropDownValueModel(name: 'Admin', value: null),
                //     DropDownValueModel(name: 'Professor', value: null),
                //     DropDownValueModel(name: 'Student', value: null),
                //   ],
                //   onChanged: (value){},
                // ),
                MyTextField(hintText: "UserType : Admin/Professor/Student",
                    controller: userTypeController,
                    tf: false,
                    focusNode: null
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                MyButton(txt: "Sign Up" ,
                  onTap: () => signup(context),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       color: Theme.of(context).colorScheme.secondary,
                //       borderRadius: BorderRadius.circular(8)
                //   ),
                //   padding: EdgeInsets.all(25),
                //   child: Center(
                //     child: Text('Sign Up',
                //       style: TextStyle(
                //         fontSize: 15,
                //         color: Colors.grey.shade300,
                //         fontWeight: FontWeight.bold,
                //         fontFamily: 'Gotham book',
                //       ),
                //     ),
                //   ),
                // ),
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
List<String> userTypee = ["Admin","Professor","Student"];