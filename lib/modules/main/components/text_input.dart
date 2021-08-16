import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final bool enabled;
  final void Function(String?) onChanged;

  TextInput(
      {required this.label, required this.onChanged, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextField(
          enabled: enabled,
          decoration: InputDecoration(
              labelText: label,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
          onChanged: onChanged),
    );
  }
}
