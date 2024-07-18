import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateBatchDialog extends StatefulWidget {
  @override
  _CreateBatchDialogState createState() => _CreateBatchDialogState();
}

class _CreateBatchDialogState extends State<CreateBatchDialog> {
  final TextEditingController _batchController = TextEditingController();

  void _createBatch() async {
    String batchName = _batchController.text.trim();
    if (batchName.isNotEmpty) {
      await FirebaseFirestore.instance.collection('batches').add({'name': batchName});
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Batch'),
      content: TextField(
        controller: _batchController,
        decoration: InputDecoration(labelText: 'Batch Name'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _createBatch,
          child: Text('Create'),
        ),
      ],
    );
  }
}
