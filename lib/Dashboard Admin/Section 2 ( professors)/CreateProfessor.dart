// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class CreateProfessorDialog extends StatefulWidget {
//   final String branchId;
//   final String branchName;
//
//   CreateProfessorDialog({required this.branchId, required this.branchName});
//
//   @override
//   _CreateProfessorDialogState createState() => _CreateProfessorDialogState();
// }
//
// class _CreateProfessorDialogState extends State<CreateProfessorDialog> {
//   final _formKey = GlobalKey<FormState>();
//   String _name = '';
//   String _email = '';
//
//   void _createProfessor() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       await FirebaseFirestore.instance.collection('professors').add({
//         'name': _name,
//         'email': _email,
//         'branchId': widget.branchId,
//       });
//       Navigator.of(context).pop();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Create Professor for ${widget.branchName}'),
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Name'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the professor name';
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 _name = value!;
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Email'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the email';
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 _email = value!;
//               },
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: _createProfessor,
//           child: Text('Create'),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateProfessorDialog extends StatefulWidget {
  final String branchId;
  final String branchName;

  CreateProfessorDialog({required this.branchId, required this.branchName});

  @override
  _CreateProfessorDialogState createState() => _CreateProfessorDialogState();
}

class _CreateProfessorDialogState extends State<CreateProfessorDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _designation = 'Professor'; // Default designation

  void _createProfessor() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseFirestore.instance.collection('professors').add({
        'name': _name,
        'email': _email,
        'designation': _designation,
        'branchId': widget.branchId,
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Professor for ${widget.branchName}'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the professor name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the email';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
            DropdownButtonFormField<String>(
              value: _designation,
              decoration: InputDecoration(labelText: 'Designation'),
              items: ['Professor', 'Assistant Professor']
                  .map((designation) => DropdownMenuItem<String>(
                value: designation,
                child: Text(designation),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _designation = value!;
                });
              },
            ),
          ],
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
          onPressed: _createProfessor,
          child: Text('Create'),
        ),
      ],
    );
  }
}
