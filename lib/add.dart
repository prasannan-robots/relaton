import 'package:flutter/material.dart';
import 'package:relaton/textentry.dart';
import 'main.dart';
import 'textentry.dart';

class add_relaton extends StatefulWidget {
  const add_relaton({Key? key}) : super(key: key);

  @override
  _add_relatonState createState() => _add_relatonState();
}

class _add_relatonState extends State<add_relaton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Relaton",
              style: TextStyle(
                  fontFamily: 'monospace',
                  color: Color.fromARGB(255, 5, 194, 153))),
        ),
        body: add_relaton_form());
  }
}

class add_relaton_form extends StatefulWidget {
  const add_relaton_form({Key? key}) : super(key: key);

  @override
  _add_relaton_formState createState() => _add_relaton_formState();
}

class _add_relaton_formState extends State<add_relaton_form> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textentrywidget(
                label_text: "Name",
                hint_text:
                    "Enter your Relaton Name"), // here place whathever child you want
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textentrywidget(
                label_text: "Phone",
                hint_text:
                    "Enter your Relaton Phone no"), // here place whathever child you want
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textentrywidget(
                label_text: "Birth_Date",
                hint_text:
                    "Enter your Relaton Birthday date"), // here place whathever child you want
          ),
          new Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: new TextButton(
                child: const Text('Submit'),
                onPressed: null,
              )),
        ],
      ),
    ));
  }
}
