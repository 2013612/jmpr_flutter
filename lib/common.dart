import 'package:flutter/material.dart';

class constant {
  static final List<String> kyokus = [
    "東一局",
    "東二局",
    "東三局",
    "東四局",
    "南一局",
    "南二局",
    "南三局",
    "南四局",
    "西一局",
    "西二局",
    "西三局",
    "西四局",
    "北一局",
    "北二局",
    "北三局",
    "北四局"
  ];
  static final Map<Position, String> positionTexts = {
    Position.Bottom: "下",
    Position.Right: "右",
    Position.Top: "上",
    Position.Left: "左"
  };
  static final List<int> hans = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    26,
    39
  ];
  static final List<int> fus = [20, 25, 30, 40, 50, 60, 70, 80, 90, 100, 110];
  static final Map<int, int> points = {
    4: 2000,
    5: 2000,
    6: 3000,
    7: 3000,
    8: 4000,
    9: 4000,
    10: 4000,
    11: 6000,
    12: 6000,
    13: 8000,
    26: 16000,
    39: 24000
  };
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

Widget FlexibleCustomCheckBoxTile(
    bool value, String title, Function onChanged) {
  return Flexible(
    child: CustomCheckBoxTile(value, title, onChanged),
  );
}

Widget CustomRadioTile(
    Position value, Position cur, String title, Function onChanged) {
  return RadioListTile<Position>(
    value: value,
    title: Text(title),
    onChanged: onChanged,
    dense: true,
    controlAffinity: ListTileControlAffinity.leading,
    groupValue: cur,
  );
}

Widget FlexibleCustomRadioTile(
    Position value, Position cur, String title, Function onChanged) {
  return Flexible(
    child: CustomRadioTile(value, cur, title, onChanged),
  );
}
