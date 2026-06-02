import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        elevation: 6,
        onPressed: onTap,
        child: Icon(CupertinoIcons.add, size: 28),
      ),
    );
  }
}
