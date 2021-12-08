import 'package:flutter/material.dart';

import '../../../common_widgets/row_input.dart';
import '../../../common_widgets/text_input.dart';
import '../../../utility/constant.dart';
import '../../../utility/enum/position.dart';
import '../../../utility/validators.dart';

class PositionPointSetting extends StatelessWidget {
  final Position position;
  final void Function(String?) onSaved;
  final TextEditingController controller;

  const PositionPointSetting(
      {Key? key,
      required this.position,
      required this.onSaved,
      required this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RowInput(
      name: Constant.positionTexts[position]!,
      widget: TextInput(
        onSaved: onSaved,
        controller: controller,
        validator: Validators.divideByHundred,
      ),
      icon: Constant.arrows[position],
    );
  }
}
