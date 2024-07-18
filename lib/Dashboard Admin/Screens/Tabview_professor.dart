import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabviewProfessor extends StatelessWidget {
  const TabviewProfessor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          child: const Column(children: [
            SizedBox(height: 20),
            Text('Manage Programmes and Professors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
          ],),
        ),
      ),
    );
  }
}
