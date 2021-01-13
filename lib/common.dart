import 'package:flutter/material.dart';

class constant {
  static final List<String> kyokus = ["東一局", "東二局", "東三局", "東四局", "南一局", "南二局", "南三局", "南四局", "西一局", "西二局", "西三局", "西四局", "北一局", "北二局", "北三局", "北四局"];
  static final Map<Position, String> positionText = {Position.Bottom: "下", Position.Right:"右", Position.Top: "上", Position.Left: "左"};
}

enum Position {
  Bottom,
  Right,
  Top,
  Left,
}

Widget BaseBarButton(String name, Function pressed, [ShapeBorder shapeBorder]) {
  shapeBorder ??= RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
  );

  return RaisedButton(
    child: Text(
      name,
    ),
    onPressed: pressed,
    textColor: Colors.black,
    color: Colors.white,
    elevation: 0.0,
    shape: shapeBorder,
  );
}

Widget CustomCheckBoxTile(bool value, String title, Function onChanged) {
  return CheckboxListTile(
    value: value,
    title: Text(title),
    onChanged: onChanged,
    dense: true,
    controlAffinity: ListTileControlAffinity.leading,
  );
}

Widget FlexibleCustomCheckBoxTile(bool value, String title, Function onChanged) {
  return Flexible(
    child: CustomCheckBoxTile(value, title, onChanged),
  );
}