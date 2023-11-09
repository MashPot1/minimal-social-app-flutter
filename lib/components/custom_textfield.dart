import 'package:flutter/material.dart';

// custom text field which takes String hintText, bool obscureText and textController from parent component

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController textController;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.textController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
      obscureText: obscureText,
      onChanged: (value) {},
    );
  }
}
