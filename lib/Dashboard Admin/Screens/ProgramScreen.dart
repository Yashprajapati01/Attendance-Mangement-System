import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Section 1 (student)/Create_Branch.dart';
import 'BranchScreen.dart';

class ProgrammeScreen extends StatelessWidget {
  final String programmeId;
  final String programmeName;

  ProgrammeScreen({required this.programmeId, required this.programmeName});

  void _createBranch(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateBranchDialog(programmeId: programmeId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programme: $programmeName'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _createBranch(context),
            child: Text('Create Branch'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('branches')
                  .where('programmeId', isEqualTo: programmeId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                var branches = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: branches.length,
                  itemBuilder: (context, index) {
                    var branch = branches[index];
                    return ListTile(
                      title: Text(branch['name']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BranchScreen(
                              branchId: branch.id,
                              branchName: branch['name'],
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
