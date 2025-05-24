import 'package:flutter/material.dart';

class tell extends StatelessWidget {
  const tell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.green,
      ),
      child: Icon(
        Icons.call,
        color: Colors.white,
        size: 40,
      ),
    );
  }

}