import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/histories.dart';
import '../../../utility/constant.dart';
import '../../../utility/enum/position.dart';

class PointRiichiDisplay extends ConsumerStatefulWidget {
  final Position position;

  PointRiichiDisplay(this.position);

  @override
  _PointRiichiDisplayState createState() => _PointRiichiDisplayState();
}

class _PointRiichiDisplayState extends ConsumerState<PointRiichiDisplay> {
  @override
  Widget build(BuildContext context) {
    final histories = ref.watch(historiesProvider);
    final index = ref.watch(historyIndexProvider);
    final setting = histories[index].setting;
    final pointSetting = histories[index].pointSetting;
    final Color _firstOyaColor = Colors.yellow;
    final Color _textColor = Colors.white;
    final position = widget.position;

    String sittingText = Constant.sittingTexts[(position.index -
            (setting.firstOya.index + pointSetting.currentKyoku) +
            8) %
        4];

    return GestureDetector(
      onTap: () {
        setState(() {
          if (!pointSetting.players[position]!.riichi) {
            pointSetting.riichibou++;
            pointSetting.players[position]!.point -= 1000;
            pointSetting.players[position]!.riichi = true;
          } else {
            pointSetting.riichibou--;
            pointSetting.players[position]!.point += 1000;
            pointSetting.players[position]!.riichi = false;
          }
        });
      },
      child: Column(
        children: [
          Spacer(),
          Image.asset(pointSetting.players[position]!.riichi
              ? "assets/riichibou.png"
              : "assets/no_riichibou.png"),
          Text(
            "$sittingText ${pointSetting.players[position]!.point}",
            style: TextStyle(
              color: setting.firstOya == position ? _firstOyaColor : _textColor,
              fontSize: 20.0,
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
