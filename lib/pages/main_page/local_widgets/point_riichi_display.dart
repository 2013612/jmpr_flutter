import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jmpr_flutter/providers/indexes_provider.dart';

import '../../../providers/games.dart';
import '../../../providers/point_setting.dart';
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
    final games = ref.watch(gamesProvider);
    final index = ref.watch(indexProvider);
    final pointSetting = ref.watch(pointSettingProvider);
    final setting = games[index.item1].setting;
    final Color _firstOyaColor = Colors.yellow;
    final Color _textColor = Colors.white;
    final position = widget.position;

    String sittingText = Constant.sittingTexts[(position.index -
            (setting.firstOya.index + pointSetting.currentKyoku) +
            8) %
        4];

    return GestureDetector(
      onTap: () => ref
          .read(pointSettingProvider.notifier)
          .toggleRiichi(position, setting.riichibouPoint),
      child: Column(
        children: [
          Spacer(),
          Image.asset(pointSetting.players[position]!.isRiichi
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
