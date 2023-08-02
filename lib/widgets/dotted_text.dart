import 'package:flutter/material.dart';

class BulletText extends StatelessWidget {
  final String text;
  const BulletText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12), 
  child: Text(
    "• $text",
    style: const TextStyle(
      color: Colors.black,
      fontSize: 16
    ),
  ),
);

  }
}
