import 'package:flutter/material.dart';

class video extends StatelessWidget {
  const video({super.key});

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
        Icons.videocam_sharp,
        color: Colors.white,
        size: 40,
      ),
    );
  }

}