import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateBranchDialogP extends StatefulWidget {
  final String programId;

  CreateBranchDialogP({required this.programId});

  @override
  _CreateBranchDialogPState createState() => _CreateBranchDialogPState();
}

class _CreateBranchDialogPState extends State<CreateBranchDialogP> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  void _createBranch() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseFirestore.instance.collection('branches').add({
        'name': _name,
        'programId': widget.programId,
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Branch'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Name'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the branch name';
            }
            return null;
          },
          onSaved: (value) {
            _name = value!;
          },
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _createBranch,
          child: Text('Create'),
        ),
      ],
    );
  }
}
