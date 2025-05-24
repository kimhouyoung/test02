import 'package:flutter/material.dart';

class chat extends StatelessWidget {
  const chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blueAccent,
      ),
      child: Icon(
        Icons.chat_bubble,
        color: Colors.white,
        size: 40,
      ),
    );
  }

}