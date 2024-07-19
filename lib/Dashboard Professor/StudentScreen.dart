import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Model/StudentDataGetter.dart';

class StudentsScreen extends StatelessWidget {
  final String branchId;

  StudentsScreen({required this.branchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: StudentsList(branchId: branchId),
    );
  }
}

class StudentsList extends StatelessWidget {
  final String branchId;

  StudentsList({required this.branchId});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('students').where('branchId', isEqualTo: branchId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No students found.'));
        }

        final studentDocs = snapshot.data!.docs;
        List<StudentDataGetter> students = studentDocs.map((doc) => StudentDataGetter.fromDocument(doc)).toList();

        return ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            return ListTile(
              title:  Text(students[index].name),
              leading:    Text('${students[index].rollNumber}',
              style: TextStyle(fontSize: 16),),
            );
          },
        );
      },
    );
  }
}
