import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: avoid_classes_with_only_static_members
class Constant {
  static Map<Position, String> positionTexts;
  static List<String> sittingTexts;

  static void languageChange(BuildContext context) {
    Constant.positionTexts = {
      Position.Bottom: AppLocalizations.of(context).bottom,
      Position.Right: AppLocalizations.of(context).right,
      Position.Top: AppLocalizations.of(context).top,
      Position.Left: AppLocalizations.of(context).left,
    };
    Constant.sittingTexts = [
      AppLocalizations.of(context).east,
      AppLocalizations.of(context).south,
      AppLocalizations.of(context).west,
      AppLocalizations.of(context).north
    ];
  }

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

  static final List<int> hans = [
    ...List.generate(13, (index) => index + 1),
    26,
    39
  ];

  static final List<int> fus = [
    20,
    25,
    ...List.generate(9, (index) => (index + 3) * 10)
  ];

  static final Map<int, int> points = {
    2: 2000,
    3: 2000,
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

  static final Map<Position, IconData> arrows = {
    Position.Bottom: Icons.arrow_downward,
    Position.Right: Icons.arrow_forward,
    Position.Top: Icons.arrow_upward,
    Position.Left: Icons.arrow_back
  };
}

enum Position {
  Bottom,
  Right,
  Top,
  Left,
}

Widget baseBarButton(String name, void Function() pressed,
    [ShapeBorder shapeBorder]) {
  shapeBorder ??= RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
  );

  return RaisedButton(
    onPressed: pressed,
    textColor: Colors.black,
    color: Colors.white,
    elevation: 0.0,
    shape: shapeBorder,
    child: Text(
      name,
    ),
  );
}

Widget customCheckBoxTile(
    bool value, String title, void Function(bool) onChanged,
    [IconData icon]) {
  return CheckboxListTile(
    value: value,
    title: Text(title),
    onChanged: onChanged,
    dense: true,
    controlAffinity: ListTileControlAffinity.leading,
    secondary: Icon(icon),
  );
}

Widget flexibleCustomCheckBoxTile(
    bool value, String title, void Function(bool) onChanged,
    [IconData icon]) {
  return Flexible(
    child: customCheckBoxTile(value, title, onChanged, icon),
  );
}

Widget customRadioTile(Position value, Position cur, String title,
    void Function(Position) onChanged, IconData icon) {
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

Widget flexibleCustomRadioTile(Position value, Position cur, String title,
    void Function(Position) onChanged, IconData icon) {
  return Flexible(
    child: customRadioTile(value, cur, title, onChanged, icon),
  );
}
