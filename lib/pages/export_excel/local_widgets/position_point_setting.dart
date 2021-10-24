import 'package:flutter/material.dart';

import '../../../utility/constant.dart';
import 'row_input.dart';
import 'text_input.dart';

class PositionPointSetting extends StatelessWidget {
  final Position position;
  final Map<Position, String> playerNames;

  const PositionPointSetting(
      {Key? key, required this.position, required this.playerNames})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RowInput(
      name: Constant.positionTexts[position]!,
      widget: TextInput(
        initialValue: playerNames[position]!,
        onSaved: (String? name) => playerNames[position] = name!,
      ),
      icon: Constant.arrows[position],
    );
  }
}
