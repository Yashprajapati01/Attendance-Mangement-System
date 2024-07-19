import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'Create_Programme.dart';

class BatchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('batches').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingAnimationWidget.inkDrop(color: Colors.white70, size: 20);
        }
        var batches = snapshot.data!.docs;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: batches.length,
          itemBuilder: (context, index) {
            var batch = batches[index];
            return ListTile(
              title: Text(batch['name']),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CreateProgrammeDialog(batchId: batch.id),
                );
              },
            );
          },
        );
      },
    );
  }
}
