import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'Model/BranchGetter.dart';
import 'StudentScreen.dart';

class BranchListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Branches'),
      ),
      body: BranchList(),
    );
  }
}

class BranchList extends StatefulWidget {
  @override
  _BranchListState createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('branches').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LoadingAnimationWidget.inkDrop(color: Colors.white70, size: 30));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No branches found.'));
        }

        final branchDocs = snapshot.data!.docs;
        List<BranchGetter> branches = branchDocs.map((doc) => BranchGetter.fromDocument(doc)).toList();

        return ListView.builder(
          itemCount: branches.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(branches[index].name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentsScreen(branchId: branches[index].id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
