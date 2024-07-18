import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateProgramDialogP extends StatefulWidget {
  @override
  _CreateProgramDialogPState createState() => _CreateProgramDialogPState();
}

class _CreateProgramDialogPState extends State<CreateProgramDialogP> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  void _createProgram() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseFirestore.instance.collection('programs').add({
        'name': _name,
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Program'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Name'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the program name';
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
          onPressed: _createProgram,
          child: Text('Create'),
        ),
      ],
    );
  }
}
