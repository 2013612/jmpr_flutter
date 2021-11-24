import 'package:flutter/material.dart';

import '../../../common_widgets/row_input.dart';
import '../../../common_widgets/text_input.dart';
import '../../../utility/constant.dart';

class PlayerNameInput extends StatelessWidget {
  final Position position;
  final Map<Position, String> playerNames;

  const PlayerNameInput(
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
