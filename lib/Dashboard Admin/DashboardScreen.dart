import 'package:attendance_mangement_system/Dashboard%20Admin/Screens/Tabview_professor.dart';
import 'package:attendance_mangement_system/Dashboard%20Admin/Screens/Tabview_students.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/Auth_Services/auth_service.dart';
import '../Auth/LoginOrSignUp.dart';
class DashboardScreen extends StatelessWidget {
  final String userId;
   DashboardScreen({super.key , required this.userId});
  final AuthService _authService = AuthService();

  void _logout(BuildContext context) async {
    await _authService.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginOrSignUp()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
        body: Column(
          children: [
            TabBar(tabs: [
              Tab(
                child: Text('For Students'),
              ),
              Tab(
                child: Text('For Professor'),
              )
            ]),
            Expanded(
              child: TabBarView(children: [
                TabviewStudents(),
                TabviewProfessor()
              ]),
            ),

          ],
        ),
      ),
    );
  }
}
