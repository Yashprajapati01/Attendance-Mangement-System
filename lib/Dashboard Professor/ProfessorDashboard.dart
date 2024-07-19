import 'package:attendance_mangement_system/Dashboard%20Professor/CourseListScreen.dart';
import 'package:attendance_mangement_system/Dashboard%20Professor/CreateCourse.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/Auth_Services/auth_service.dart';
import '../Auth/LoginOrSignUp.dart';
import 'Course_details.dart';
import 'BranchListScreen.dart';

class ProfessorDashboardScreen extends StatelessWidget {
  ProfessorDashboardScreen({Key? key}) : super(key: key);
  final AuthService _authService = AuthService();

  void _createCourse(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateCourseScreen(),
    );
  }

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Professor Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () =>  _createCourse(context),
              child: const Card(
                color: Color(0xff4B70F5),
                child: Padding(
                  padding: EdgeInsets.all(16.0), // padding inside the Card
                  child: Column(
                    children: [
                      Row(
                        children: [Text('Add',
                          style: TextStyle(
                              fontSize: 20
                          ),)],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Course Here',
                            style: TextStyle(
                                fontSize: 20
                            ),),
                          Icon(Icons.add),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Courses List :',
                  style: TextStyle(
                      fontSize: 16
                  ),),
              ],
            ),
            Expanded(child: CourseListScreen())
          ],
        ),
      ),
      // body: Column(
      //   children: [
      //     ElevatedButton(
      //       onPressed: () => _createCourse(context),
      //       child: Text('Create Course'),
      //     ),
      //     Expanded(
      //       child: StreamBuilder<QuerySnapshot>(
      //         stream: FirebaseFirestore.instance.collection('courses').snapshots(),
      //         builder: (context, snapshot) {
      //           if (!snapshot.hasData) {
      //             return Center(child: LoadingAnimationWidget.inkDrop(color: Colors.white70, size: 20));
      //           }
      //           if (snapshot.hasError) {
      //             return Center(child: Text('Error: ${snapshot.error}'));
      //           }
      //
      //           var courses = snapshot.data!.docs;
      //           if (courses.isEmpty) {
      //             return Center(child: Text('No courses available.'));
      //           }
      //
      //           return ListView.builder(
      //             itemCount: courses.length,
      //             itemBuilder: (context, index) {
      //               var course = courses[index];
      //               return ListTile(
      //                 title: Text(course['courseName'] ?? 'Unnamed Course'),
      //                 subtitle: Text('Course ID: ${course.id}'),
      //                 onTap: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => CourseScreen(courseId: course.id),
      //                     ),
      //                   );
      //                 },
      //               );
      //             },
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
