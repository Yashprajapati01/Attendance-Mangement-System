import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateProgrammeDialog extends StatefulWidget {
  final String batchId;

  CreateProgrammeDialog({required this.batchId});

  @override
  _CreateProgrammeDialogState createState() => _CreateProgrammeDialogState();
}

class _CreateProgrammeDialogState extends State<CreateProgrammeDialog> {
  final TextEditingController _programmeController = TextEditingController();

  void _createProgramme() async {
    String programmeName = _programmeController.text.trim();
    if (programmeName.isNotEmpty) {
      await FirebaseFirestore.instance.collection('programmes').add({
        'name': programmeName,
        'batchId': widget.batchId,
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Programme'),
      content: TextField(
        controller: _programmeController,
        decoration: InputDecoration(labelText: 'Programme Name'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _createProgramme,
          child: Text('Create'),
        ),
      ],
    );
  }
}
