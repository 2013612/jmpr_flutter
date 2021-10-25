import 'package:flutter/material.dart';

import '../../../common_widgets/custom_check_box_tile.dart';
import '../../../utility/constant.dart';

class RonCheckBoxListTile extends StatelessWidget {
  final Position position;
  final bool? checkBoxValue;
  final void Function(bool?) onChanged;

  const RonCheckBoxListTile({
    Key? key,
    required this.position,
    required this.checkBoxValue,
    required this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CustomCheckBoxTile(
        checkBoxValue: checkBoxValue ?? false,
        title: Constant.positionTexts[position]!,
        onChanged: onChanged,
        icon: Constant.arrows[position],
      ),
    );
  }
}
