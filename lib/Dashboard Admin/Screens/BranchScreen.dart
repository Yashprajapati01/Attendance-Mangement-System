import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Section 1 (student)/Create_Student.dart';

class BranchScreen extends StatelessWidget {
  final String branchId;
  final String branchName;

  BranchScreen({required this.branchId, required this.branchName});

  void _createStudent(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateStudentDialog(branchId: branchId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Branch: $branchName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _createStudent(context),
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
                          Text('Students Here',
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
                Text('Branch List :',
                  style: TextStyle(
                      fontSize: 16
                  ),),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('students')
                    .where('branchId', isEqualTo: branchId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return LoadingAnimationWidget.inkDrop(color: Colors.white70, size: 20);
                  }
                  var students = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      var student = students[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: Text(student['rollNumber']),
                            subtitle: Text(student['email']),
                            leading: Text(student['name'] ,
                            style: TextStyle(fontSize: 16),),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
