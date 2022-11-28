import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController? controller;

  const InputField(
      {this.inputType = TextInputType.text,
      required this.hint,
      this.inputAction = TextInputAction.next,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      textInputAction: inputAction,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(8),
      ),
    );
  }
}
