import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () =>  _createProgramme(context),
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
                          Text('Program Here',
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
                    .collection('programmes')
                    .where('batchId', isEqualTo: batchId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return LoadingAnimationWidget.inkDrop(color: Colors.white70, size: 20);
                  }
                  var programmes = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: programmes.length,
                    itemBuilder: (context, index) {
                      var programme = programmes[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: Text(programme['name']),
                            leading: const Text('Program :',
                              style: TextStyle(
                                  fontSize: 16
                              ),),
                            trailing: Icon(CupertinoIcons.forward),
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
