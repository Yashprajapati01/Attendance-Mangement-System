import 'package:cloud_firestore/cloud_firestore.dart';

class StudentDataGetter {
  final String id;
  final String branchId;
  final String name;
  final String rollNumber;

  StudentDataGetter({required this.id, required this.branchId, required this.name,  required this.rollNumber});

  factory StudentDataGetter.fromDocument(DocumentSnapshot doc) {
    return StudentDataGetter(
      id: doc.id,
      branchId: doc['branchId'] as String,
      name: doc['name'] as String,
      rollNumber: doc['rollNumber'] as String,
    );
  }
}
