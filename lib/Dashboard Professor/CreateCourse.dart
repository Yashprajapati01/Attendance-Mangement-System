
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'SelectStudentScreen.dart'; // Make sure this path is correct

class CreateCourseScreen extends StatefulWidget {
  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  String _courseCode = '';
  String _courseName = '';
  String? _selectedBranch;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _createCourse() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save the course details to Firestore
      DocumentReference courseRef = await _firestore.collection('courses').add({
        'courseCode': _courseCode,
        'courseName': _courseName,
        'branchId': _selectedBranch,
        'studentIds': [], // Initial empty list of student IDs
      });

      // Navigate to the student selection screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectStudentsScreen(
            branchId: _selectedBranch!,
            courseId: courseRef.id, // Ensure this matches with the SelectStudentsScreen parameter
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create Course'),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Course Code'),
                          onSaved: (value) {
                            _courseCode = value ?? '';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a course code';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Course Name'),
                          onSaved: (value) {
                            _courseName = value ?? '';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a course name';
                            }
                            return null;
                          },
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore.collection('branches').snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }

                            final branches = snapshot.data!.docs;
                            List<DropdownMenuItem<String>> branchItems = branches.map((branch) {
                              return DropdownMenuItem<String>(
                                value: branch.id,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 100,
                                  child: Text(
                                    branch['name'],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              );
                            }).toList();

                            return DropdownButtonFormField<String>(
                              decoration: InputDecoration(labelText: 'Branch'),
                              items: branchItems,
                              value: _selectedBranch,
                              onChanged: (value) {
                                setState(() {
                                  _selectedBranch = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a branch';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _createCourse,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff4B70F5)
                          ),
                          child: Text('Create Course',
                          style: TextStyle(
                            color: Colors.white
                          ),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
