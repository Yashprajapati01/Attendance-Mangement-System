// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'Section 1 (student)/Create_Batch.dart';
// import 'Section 1 (student)/BatchList.dart';
// import 'Section 1 (student)/Create_Programme.dart';
//
// class AdminDashboardScreen extends StatelessWidget {
//   final String userId;
//
//   const AdminDashboardScreen({required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Dashboard'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 20),
//             Text('Manage Batches and Students', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Section1(),
//             SizedBox(height: 20),
//             Text('Manage Programmes and Professors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             // Section2(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Section1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (context) => CreateBatchDialog(),
//             );
//           },
//           child: Text('Create Batch'),
//         ),
//         BatchList(),
//       ],
//     );
//   }
// }

// class Section2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (context) => CreateProgrammeDialog(),
//             );
//           },
//           child: Text('Create Programme'),
//         ),
//         ProgrammeList(),
//       ],
//     );
//   }
// }
