import 'package:flutter/material.dart';

class RowInput extends StatelessWidget {
  final String name;
  final Widget widget;
  final IconData? icon;

  const RowInput(
      {Key? key, required this.name, required this.widget, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (icon != null) {
      child = Row(
        children: [
          Text(name),
          Icon(icon),
        ],
      );
    } else {
      child = Text(name);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          child: child,
        ),
        Container(
          width: 200,
          padding: EdgeInsets.all(8.0),
          child: widget,
        ),
      ],
    );
  }
}
