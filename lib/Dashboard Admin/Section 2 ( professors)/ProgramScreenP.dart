import 'package:attendance_mangement_system/Dashboard%20Admin/Section%202%20(%20professors)/Branch_ScreenP.dart';
import 'package:attendance_mangement_system/Dashboard%20Admin/Section%202%20(%20professors)/createBranchP.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgramScreenP extends StatelessWidget {
  final String programId;
  final String programName;

  ProgramScreenP({required this.programId, required this.programName});

  void _createBranch(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateBranchDialogP(programId: programId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Program: $programName'),
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
                        children: [Text('Manage',
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
                    .where('programId', isEqualTo: programId)
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
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: ListTile(
                            title: Text(branch['name']),
                            leading: const Text('Branch :',
                              style: TextStyle(
                                  fontSize: 16
                              ),),
                            trailing: Icon(CupertinoIcons.forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BranchScreenP(
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
