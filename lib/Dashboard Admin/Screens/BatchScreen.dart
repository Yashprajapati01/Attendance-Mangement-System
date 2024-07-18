import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Section 1 (student)/Create_Programme.dart';
import 'ProgramScreen.dart';

class BatchScreen extends StatelessWidget {
  final String batchId;
  final String batchName;

  BatchScreen({required this.batchId, required this.batchName});

  void _createProgramme(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateProgrammeDialog(batchId: batchId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batch: $batchName'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _createProgramme(context),
            child: Text('Create Programme'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('programmes')
                  .where('batchId', isEqualTo: batchId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                var programmes = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: programmes.length,
                  itemBuilder: (context, index) {
                    var programme = programmes[index];
                    return ListTile(
                      title: Text(programme['name']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProgrammeScreen(
                              programmeId: programme.id,
                              programmeName: programme['name'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
