import 'package:attendance_mangement_system/Dashboard%20Admin/Section%202%20(%20professors)/ProgramScreenP.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Section 2 ( professors)/CreateProgramP.dart';

class TabviewProfessor extends StatelessWidget {
  void _createProgram(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateProgramDialogP(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () =>  _createProgram(context),
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
                          Text('Programs Here',
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
                Text('Program List :',
                  style: TextStyle(
                      fontSize: 16
                  ),),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('programs').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return LoadingAnimationWidget.inkDrop(color: Colors.white70, size: 20);
                  }
                  var programs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: programs.length,
                    itemBuilder: (context, index) {
                      var program = programs[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: ListTile(
                            title: Text(program['name']),
                            leading: const Text('Program :',
                              style: TextStyle(
                                  fontSize: 16
                              ),),
                            trailing: Icon(CupertinoIcons.forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProgramScreenP(
                                    programId: program.id,
                                    programName: program['name'],
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
