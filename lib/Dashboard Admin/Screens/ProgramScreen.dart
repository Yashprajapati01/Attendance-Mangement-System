import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () =>  _createBranch(context),
              child: const Card(
                color: Color(0xff4B70F5),
                child: Padding(
                  padding: EdgeInsets.all(16.0), // padding inside the Card
                  child: Column(
                    children: [
                      Row(
                        children: [Text('Add',
                          style: TextStyle(
                              fontSize: 20
                          ),)],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Branch Here',
                            style: TextStyle(
                                fontSize: 20
                            ),),
                          Icon(Icons.add),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Branch List :',
                  style: TextStyle(
                      fontSize: 16
                  ),),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('branches')
                    .where('programmeId', isEqualTo: programmeId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return LoadingAnimationWidget.inkDrop(color: Colors.white70, size: 20);
                  }
                  var branches = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: branches.length,
                    itemBuilder: (context, index) {
                      var branch = branches[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: Text(branch['name']),
                            leading: Text('Branch :',
                              style: TextStyle(
                                  fontSize: 16
                              ),),
                            trailing: Icon(CupertinoIcons.forward),
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
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
