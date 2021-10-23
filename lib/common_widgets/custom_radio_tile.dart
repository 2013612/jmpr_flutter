import 'package:flutter/material.dart';

import '../common.dart';

class CustomRadioTile extends StatelessWidget {
  final Position value;
  final Position cur;
  final String title;
  final void Function(Position?) onChanged;
  final IconData icon;

  const CustomRadioTile({
    Key? key,
    required this.value,
    required this.cur,
    required this.title,
    required this.onChanged,
    required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RadioListTile<Position>(
      value: value,
      title: Text(title),
      onChanged: onChanged,
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      groupValue: cur,
      secondary: Icon(icon),
    );
  }
}
