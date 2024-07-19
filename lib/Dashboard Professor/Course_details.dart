import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CourseScreen extends StatelessWidget {
  final String courseId;

  CourseScreen({required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('courses')
            .doc(courseId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingAnimationWidget.inkDrop(color: Colors.white70, size: 20);
          }
          var course = snapshot.data!;
          List<dynamic> studentIds = course['students'];
          return ListView.builder(
            itemCount: studentIds.length,
            itemBuilder: (context, index) {
              String studentId = studentIds[index];
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('students')
                    .doc(studentId)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  var student = snapshot.data!;
                  return ListTile(
                    title: Text(student['name']),
                    subtitle: Text(student['rollNumber']),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Mark attendance logic here
                      },
                      child: Text('Mark Attendance'),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
