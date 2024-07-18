import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateBranchDialog extends StatefulWidget {
  final String programmeId;

  CreateBranchDialog({required this.programmeId});

  @override
  _CreateBranchDialogState createState() => _CreateBranchDialogState();
}

class _CreateBranchDialogState extends State<CreateBranchDialog> {
  final TextEditingController _branchController = TextEditingController();

  void _createBranch() async {
    String branchName = _branchController.text.trim();
    if (branchName.isNotEmpty) {
      await FirebaseFirestore.instance.collection('branches').add({
        'name': branchName,
        'programmeId': widget.programmeId,
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Branch'),
      content: TextField(
        controller: _branchController,
        decoration: InputDecoration(labelText: 'Branch Name'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
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
