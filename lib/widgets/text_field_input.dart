import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController
      textEditingController; // listens to user input and updates in real-time
  final bool isPassword;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput(
      {Key? key,
      required this.textEditingController,
      this.isPassword = false,
      required this.hintText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPassword,
    );
  }
}
