import 'package:attendance_mangement_system/components/MyTextInputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Auth/Auth_Services/auth_service.dart';
import '../components/Button.dart';
import 'DashboardScreen.dart';
import 'Forget_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key , required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final AuthService _authService = AuthService();

  // void login(BuildContext context) async {
  //   User? user = await _authService.signInWithEmailAndPassword(
  //     emailController.text,
  //     passController.text,
  //   );
  //   if (user != null) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => DashboardScreen()),
  //     );
  //   } else {
  //     print('Login failed');
  //   }
  // }

  bool? ischecked = false;
  @override
  void initState() {
    super.initState();
    loadRememberedUser();
  }

  void loadRememberedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? remembered = prefs.getBool('remember_me');
    if (remembered == true) {
      String? email = prefs.getString('email');
      String? password = prefs.getString('password');
      if (email != null && password != null) {
        setState(() {
          emailController.text = email;
          passController.text = password;
          ischecked = true;
        });
        _login(email, password, context , automatic: true);
      }
    }
  }

  void _login(String email, String password, BuildContext context, {bool automatic = false}) async {
    if (email.isEmpty || password.isEmpty) {
      if (!automatic) {
        _showErrorDialog(context, 'Email and Password cannot be empty.');
      }
      return;
    }

    try {
      User? user = await _authService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        if (ischecked == true) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('remember_me', true);
          await prefs.setString('email', email);
          await prefs.setString('password', password);
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      }
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  final _formkey = GlobalKey<FormState>();

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
                Text('Welcome! Log in to view your dashboard',
                  style: TextStyle(
                      fontFamily: 'Gotham book',
                      color: Colors.grey.shade300,
                    fontSize: 15
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                MyTextField(hintText: 'Roll Number / Email',controller: emailController, tf: false, focusNode: null),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                MyTextField(hintText: 'Password', controller: passController, tf: true, focusNode: null),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Transform.scale(
                      scale: 0.80,
                      child: Checkbox(value: ischecked,
                          activeColor: Colors.grey.shade300,
                          onChanged:(newValue){
                            setState(() {
                              ischecked = newValue;
                            });
                          }),
                    ),
            Text('Remember me',
              style: TextStyle(
                  color: Colors.grey.shade300,
                fontFamily: 'Gotham book',
                fontSize: 13
              ),
            )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.040),
                // Container(
                //   decoration: BoxDecoration(
                //       color: Theme.of(context).colorScheme.secondary,
                //       borderRadius: BorderRadius.circular(8)
                //   ),
                //   padding: EdgeInsets.all(25),
                //   child: MyButton(txt: "Login" ,
                //       onTap: () => login(context),
                //   ),
                // ),
                MyButton(txt: "Login", onTap: () => _login(emailController.text, passController.text, context)),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),

                // forgot password

                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: Text("Forgot Password?",
                      style: TextStyle(
                          fontFamily: 'Gotham',
                          color: Colors.grey.shade300,
                          fontSize: 12
                      ),
                    ),
                  ),
                ),


                // forgot password ends here
                SizedBox(height: MediaQuery.of(context).size.width * 0.13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member ?",
                      style: TextStyle(
                          fontFamily: 'Gotham book',
                          color: Colors.grey.shade300,
                          fontSize: 12
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(" Register Now",
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
