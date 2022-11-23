import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;

  const PasswordField({this.controller, required this.label});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: !_isVisible,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
          labelText: 'password',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(8),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Icon(_isVisible ? Icons.visibility : Icons.visibility_off),
          )),
    );
  }
}
