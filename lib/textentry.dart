import 'package:flutter/material.dart';
import 'main.dart';

class textentrywidget extends StatefulWidget {
  final String label_text, hint_text, initialValue;
  const textentrywidget(
      {Key? key,
      this.label_text = "",
      this.hint_text = "",
      this.initialValue = ""})
      : super(key: key);

  @override
  _textentrywidgetState createState() => _textentrywidgetState();
}

class _textentrywidgetState extends State<textentrywidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      cursorColor: gren,
      cursorWidth: 6,
      style: TextStyle(color: gren, fontFamily: "monospace"),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: gren, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        fillColor: Color.fromARGB(255, 39, 39, 39),
        labelStyle: TextStyle(color: gren, fontFamily: "monospace"),
        filled: true,
        hintText: widget.hint_text,
        labelText: widget.label_text,
      ),
    );
  }
}
