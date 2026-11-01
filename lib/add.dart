import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main.dart' show green;
import 'relaton.dart';
import 'textentry.dart';

class AddRelatonPage extends StatefulWidget {
  const AddRelatonPage({super.key});

  @override
  State<AddRelatonPage> createState() => _AddRelatonPageState();
}

class _AddRelatonPageState extends State<AddRelatonPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  DateTime? _birthday;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _pickBirthday() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthday ?? DateTime(now.year - 20),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) setState(() => _birthday = picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      Relaton(
        name: _name.text.trim(),
        phone: _phone.text.trim(),
        birthday: _birthday,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Relaton')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextEntryWidget(
                controller: _name,
                labelText: 'Name',
                hintText: "Your relaton's name",
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),
              TextEntryWidget(
                controller: _phone,
                labelText: 'Phone',
                hintText: 'Phone number (optional)',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: green,
                  side: const BorderSide(color: green, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _pickBirthday,
                icon: const Icon(Icons.cake_outlined),
                label: Text(
                  _birthday == null ? 'Pick a birthday (optional)' : DateFormat.yMMMMd().format(_birthday!),
                ),
              ),
              const SizedBox(height: 32),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: green,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _submit,
                child: const Text('Save', style: TextStyle(fontFamily: 'monospace', fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
