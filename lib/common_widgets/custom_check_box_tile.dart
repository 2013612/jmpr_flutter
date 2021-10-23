import 'package:flutter/material.dart';

class CustomCheckBoxTile extends StatelessWidget {
  final bool checkBoxValue;
  final String title;
  final void Function(bool?) onChanged;
  final IconData? icon;
  CustomCheckBoxTile(
      // ignore: avoid_positional_boolean_parameters
      {
    required this.checkBoxValue,
    required this.title,
    required this.onChanged,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: checkBoxValue,
      title: Text(title),
      onChanged: onChanged,
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      secondary: Icon(icon),
    );
  }
}
