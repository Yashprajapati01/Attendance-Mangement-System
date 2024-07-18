import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'CreateProfessor.dart';

class BranchScreenP extends StatelessWidget {
  final String branchId;
  final String branchName;

  BranchScreenP({required this.branchId, required this.branchName});

  void _createProfessor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateProfessorDialog(branchId: branchId, branchName: branchName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Branch: $branchName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () =>  _createProfessor(context),
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
                          Text('Professors Here',
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
                Text('Professors List :',
                  style: TextStyle(
                      fontSize: 16
                  ),),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('professors')
                    .where('branchId', isEqualTo: branchId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  var professors = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: professors.length,
                    itemBuilder: (context, index) {
                      var professor = professors[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text(professor['name']),
                            subtitle: Text('${professor['email']} - ${professor['designation']}'),
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
// title: Text(professor['name']),
// subtitle: Text(professor['email']),
// leading: const Text('',
// style: TextStyle(
// fontSize: 16
// ),
// ),