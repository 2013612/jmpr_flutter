import 'package:flutter/material.dart';

import '../../../common_widgets/custom_check_box_tile.dart';
import '../../../utility/constant.dart';
import '../../../utility/enum/position.dart';

class FlexibleCustomCheckBoxTile extends StatefulWidget {
  final Map<Position, bool> map;
  final Position position;

  const FlexibleCustomCheckBoxTile(
      {Key? key, required this.map, required this.position})
      : super(key: key);

  @override
  State<FlexibleCustomCheckBoxTile> createState() =>
      _FlexibleCustomCheckBoxTileState();
}

class _FlexibleCustomCheckBoxTileState
    extends State<FlexibleCustomCheckBoxTile> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CustomCheckBoxTile(
        checkBoxValue: widget.map[widget.position] ?? false,
        title: Constant.positionTexts[widget.position]!,
        onChanged: (bool? isNagashimangan) {
          setState(() {
            widget.map[widget.position] = isNagashimangan ?? false;
          });
        },
        icon: Constant.arrows[widget.position],
      ),
    );
  }
}
