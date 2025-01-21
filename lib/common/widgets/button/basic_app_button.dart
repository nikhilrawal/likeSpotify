import 'package:flutter/material.dart';

Widget BasicAppButton(
    {final double? height,
    required final VoidCallback onpressed,
    required final String text}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(height ?? 80)),
    onPressed: onpressed,
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Color(0xFFF6F6F6),
      ),
    ),
  );
}
