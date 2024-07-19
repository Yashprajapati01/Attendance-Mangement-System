import 'package:attendance_mangement_system/Dashboard%20Professor/ProfessorDashboard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectStudentsScreen extends StatefulWidget {
  final String branchId;
  final String courseId;

  SelectStudentsScreen({required this.branchId, required this.courseId});

  @override
  _SelectStudentsScreenState createState() => _SelectStudentsScreenState();
}

class _SelectStudentsScreenState extends State<SelectStudentsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, bool> _selectedStudents = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select Students'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select Students from here',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('students').where('branchId', isEqualTo: widget.branchId).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
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
                          child: CheckboxListTile(
                            title: Text('${student['name']} (${student['rollNumber']})'),
                            value: _selectedStudents[student.id] ?? false,
                            onChanged: (bool? value) {
                              setState(() {
                                _selectedStudents[student.id] = value ?? false;
                              });
                            },
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: _saveSelectedStudents,
      ),
    );
  }

  void _saveSelectedStudents() {
    List<String> selectedStudentIds = _selectedStudents.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    _firestore.collection('courses').doc(widget.courseId).update({
      'studentIds': selectedStudentIds,
    }).then((_) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfessorDashboardScreen()),
      );
    }).catchError((error) {
      print('Error updating course: $error');
    });
  }
}
