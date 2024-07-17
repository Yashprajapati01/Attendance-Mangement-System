import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _createStudent(context),
            child: Text('Create Student'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('students')
                  .where('branchId', isEqualTo: branchId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                var students = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    var student = students[index];
                    return ListTile(
                      title: Text(student['name']+ '   '+student['rollNumber']),
                      subtitle: Text(student['email']),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
