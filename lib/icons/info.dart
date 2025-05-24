import 'package:flutter/material.dart';

class info extends StatelessWidget {
  const info({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey,
      ),
      child: Icon(
        Icons.info,
        color: Colors.white,
        size: 40,
      ),
    );
  }

}