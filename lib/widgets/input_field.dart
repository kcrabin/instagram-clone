import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController? controller;

  const InputField(
      {this.inputType = TextInputType.text,
      required this.label,
      this.inputAction = TextInputAction.next,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      textInputAction: inputAction,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(8),
      ),
    );
  }
}
