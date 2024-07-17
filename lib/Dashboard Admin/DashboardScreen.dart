import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/Auth_Services/auth_service.dart';
import '../Auth/LoginOrSignUp.dart';
import 'Screens/BatchScreen.dart';
import 'Section 1 (student)/BatchList.dart';
import 'Section 1 (student)/Create_Batch.dart';
import '../Screens/Login_Screen.dart';
class DashboardScreen extends StatelessWidget {
  final String userId;
   DashboardScreen({super.key , required this.userId});
  final AuthService _authService = AuthService();

  void _logout(BuildContext context) async {
    await _authService.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginOrSignUp()),
          (route) => false,
    );
  }
  void _createBatch(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateBatchDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
                const Text('Manage Batches and Students', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                // Section1(),
                // Section2(),
          ElevatedButton(
            onPressed: () => _createBatch(context),
            child: const Text('Create Batch'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('batches').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                var batches = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: batches.length,
                  itemBuilder: (context, index) {
                    var batch = batches[index];
                    return ListTile(
                      title: Text(batch['name']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BatchScreen(
                              batchId: batch.id,
                              batchName: batch['name'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text('Manage Programmes and Professors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       SizedBox(height: 20),
      //       Text('Manage Batches and Students', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      //       SizedBox(height: 10),
      //       Section1(),
      //       SizedBox(height: 20),
      //       Text('Manage Programmes and Professors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      //       SizedBox(height: 10),
      //       // Section2(),
      //     ],
      //   ),
      // ),
    );
  }
}

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