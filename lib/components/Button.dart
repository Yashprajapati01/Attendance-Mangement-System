import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {
  final String txt;
  final void Function()? onTap;
  const MyButton({super.key, required this.txt, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8)
        ),
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Text(txt),
        ),
      ),
    );
  }
}