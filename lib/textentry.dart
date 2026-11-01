import 'package:flutter/material.dart';

import 'main.dart' show green;

/// A themed text field used across the app.
class TextEntryWidget extends StatelessWidget {
  const TextEntryWidget({
    super.key,
    this.controller,
    this.labelText = '',
    this.hintText = '',
    this.keyboardType,
    this.validator,
  });

  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      cursorColor: green,
      cursorWidth: 6,
      style: const TextStyle(color: green, fontFamily: 'monospace'),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: green, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: green, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: const Color.fromARGB(255, 39, 39, 39),
        labelStyle: const TextStyle(color: green, fontFamily: 'monospace'),
        filled: true,
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}
