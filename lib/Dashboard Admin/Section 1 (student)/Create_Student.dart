import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateStudentDialog extends StatefulWidget {
  final String branchId;

  CreateStudentDialog({required this.branchId});

  @override
  _CreateStudentDialogState createState() => _CreateStudentDialogState();
}

class _CreateStudentDialogState extends State<CreateStudentDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _createStudent() async {
    String name = _nameController.text.trim();
    String rollNumber = _rollNumberController.text.trim();
    String email = _emailController.text.trim();
    if (name.isNotEmpty && rollNumber.isNotEmpty && email.isNotEmpty) {
      await FirebaseFirestore.instance.collection('students').add({
        'name': name,
        'rollNumber': rollNumber,
        'email': email,
        'branchId': widget.branchId,
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Student'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _rollNumberController,
            decoration: InputDecoration(labelText: 'Roll Number'),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _createStudent,
          child: Text('Create'),
        ),
      ],
    );
  }
}
