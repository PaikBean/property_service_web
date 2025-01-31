import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  final String title;
  const SubTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "| $title",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.grey[800],
      ),
    );
  }
}
