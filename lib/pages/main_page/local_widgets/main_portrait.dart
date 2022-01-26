import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nil/nil.dart';

import '../../../providers/games_provider.dart';
import '../../../providers/indexes_provider.dart';
import '../../../providers/point_setting_provider.dart';
import '../../../utility/constant.dart';
import '../../../utility/enum/position.dart';
import 'point_riichi_display.dart';

class MainPortrait extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = AppLocalizations.of(context)!;
    final pointSetting = ref.watch(pointSettingProvider);
    final middleTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    );

    void showResult() {
      final indexes = ref.watch(indexesProvider);
      Map<Position, double> marks = ref
          .watch(gamesProvider)[indexes.gameIndex]
          .calResult(indexes.pointSettingIndex);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(i18n.result),
          content: Column(
            children: marks.entries
                .map((mark) => Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            Constant.positionTexts[mark.key]!,
                          ),
                        ),
                        Text(
                          mark.value.toStringAsFixed(2),
                        ),
                      ],
                    ))
                .toList(),
          ),
          scrollable: true,
        ),
      );
    }

    return Center(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        children: [
          nil,
          Center(
            child: RotatedBox(
              quarterTurns: 2,
              child: PointRiichiDisplay(Position.top),
            ),
          ),
          nil,
          Center(
            child: RotatedBox(
              quarterTurns: 1,
              child: PointRiichiDisplay(Position.left),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  Constant.kyokus[pointSetting.currentKyoku],
                  style: middleTextStyle,
                ),
                Text(
                  "${pointSetting.bonba} 本場",
                  style: middleTextStyle,
                ),
                Text(
                  "供托: ${pointSetting.riichibou}",
                  style: middleTextStyle,
                ),
              ],
            ),
          ),
          Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: PointRiichiDisplay(Position.right),
            ),
          ),
          nil,
          Center(
            child: PointRiichiDisplay(Position.bottom),
          ),
          FractionallySizedBox(
            heightFactor: 0.3,
            widthFactor: 0.6,
            child: ElevatedButton(
              onPressed: showResult,
              child: Text(i18n.result),
            ),
          ),
        ],
      ),
    );
  }
}
