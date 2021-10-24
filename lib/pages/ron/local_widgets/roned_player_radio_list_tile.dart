import 'package:flutter/material.dart';
import 'package:jmpr_flutter/common_widgets/custom_radio_tile.dart';
import 'package:jmpr_flutter/utility/constant.dart';

class RonedPlayerRadioListTile extends StatelessWidget {
  final Position position;
  final Position cur;
  final void Function(Position?) onChanged;

  const RonedPlayerRadioListTile(
      {Key? key,
      required this.position,
      required this.cur,
      required this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CustomRadioTile(
        value: position,
        cur: cur,
        title: Constant.positionTexts[position]!,
        onChanged: onChanged,
        icon: Constant.arrows[position]!,
      ),
    );
  }
}
