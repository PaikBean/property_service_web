import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  final String title;
  const MainTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "| $title",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.grey[800],
      ),
    );
  }
}
