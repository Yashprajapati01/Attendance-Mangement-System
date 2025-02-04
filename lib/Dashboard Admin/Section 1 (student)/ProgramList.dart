import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'Create_Branch.dart';

class ProgrammeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('programmes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingAnimationWidget.inkDrop(color: Colors.white70, size: 20);
        }
        var programmes = snapshot.data!.docs;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: programmes.length,
          itemBuilder: (context, index) {
            var programme = programmes[index];
            return ListTile(
              title: Text(programme['name']),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CreateBranchDialog(programmeId: programme.id),
                );
              },
            );
          },
        );
      },
    );
  }
}
