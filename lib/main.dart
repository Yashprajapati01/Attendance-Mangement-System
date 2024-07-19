import 'package:attendance_mangement_system/Auth/Auth_gate.dart';
import 'package:attendance_mangement_system/Auth/LoginOrSignUp.dart';
import 'package:attendance_mangement_system/Dashboard%20Professor/ProfessorDashboard.dart';
import 'package:attendance_mangement_system/Screens/Login_Screen.dart';
import 'package:attendance_mangement_system/Screens/SignUp_Screen.dart';
import 'package:attendance_mangement_system/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:attendance_mangement_system/Theme/dark_mode.dart';

import 'Dashboard Admin/DashboardScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkMode,
      title: 'Attendance Management System',
      home: ProfessorDashboardScreen(),
    );
  }
}