import 'package:cloud_firestore/cloud_firestore.dart';

class BranchGetter {
  final String id;
  final String name;

  BranchGetter({required this.id, required this.name});

  factory BranchGetter.fromDocument(DocumentSnapshot doc) {
    return BranchGetter(
      id: doc.id,
      name: doc['name'] as String,
    );
  }
}
