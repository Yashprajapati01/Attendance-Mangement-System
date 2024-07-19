import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CourseDetailScreen extends StatelessWidget {
  final String coursesId;
  final String courseName;

  CourseDetailScreen({required this.coursesId, required this.courseName});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(courseName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: _firestore.collection('courses').doc(coursesId).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: LoadingAnimationWidget.inkDrop(color: Colors.white70, size: 30));
            }

            final courseData = snapshot.data!;
            final List<dynamic> studentIds = courseData['studentIds'];

            if (studentIds.isEmpty) {
              return Center(child: Text('No students enrolled in this course.'));
            }

            return FutureBuilder<QuerySnapshot>(
              future: _firestore.collection('students').where(FieldPath.documentId, whereIn: studentIds).get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: LoadingAnimationWidget.inkDrop(color: Colors.white70, size: 30));
                }

                final students = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(student['name']),
                          subtitle: Text(student['rollNumber']),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
