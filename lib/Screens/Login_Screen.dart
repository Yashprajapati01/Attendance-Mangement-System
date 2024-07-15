import 'package:attendance_mangement_system/components/MyTextInputField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  LoginScreen({super.key , required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? ischecked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
                MyTextField(hintText: 'Roll Number / Email', tf: false, focusNode: null),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                MyTextField(hintText: 'Password', tf: true, focusNode: null),
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
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  padding: EdgeInsets.all(25),
                  child: Center(
                    child: Text('Login',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade300,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gotham book',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),
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
