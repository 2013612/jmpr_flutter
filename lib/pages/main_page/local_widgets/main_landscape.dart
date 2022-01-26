import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jmpr_flutter/providers/indexes_provider.dart';

import '../../../providers/games.dart';
import '../../../providers/point_setting.dart';
import '../../../utility/constant.dart';
import '../../../utility/enum/position.dart';
import 'point_riichi_display.dart';

class MainLandscape extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = AppLocalizations.of(context)!;
    final pointSetting = ref.watch(pointSettingProvider);
    final middleTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    );

    void showResult() {
      final indexes = ref.watch(indexProvider);
      Map<Position, double> marks =
          ref.watch(gamesProvider)[indexes.item1].calResult(indexes.item2);

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

    return Row(
      children: [
        Spacer(),
        Flexible(
          child: RotatedBox(
            quarterTurns: 1,
            child: PointRiichiDisplay(Position.left),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: RotatedBox(
                quarterTurns: 2,
                child: PointRiichiDisplay(Position.top),
              ),
            ),
            Spacer(
              flex: 3,
            ),
            Flexible(child: PointRiichiDisplay(Position.bottom)),
          ],
        ),
        Flexible(
          child: RotatedBox(
            quarterTurns: 3,
            child: PointRiichiDisplay(Position.right),
          ),
        ),
        Spacer(),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(
                flex: 3,
              ),
              Text(
                Constant.kyokus[pointSetting.currentKyoku],
                style: middleTextStyle,
              ),
              Spacer(),
              Text(
                "${pointSetting.bonba} 本場",
                style: middleTextStyle,
              ),
              Spacer(),
              Text(
                "供托: ${pointSetting.riichibou}",
                style: middleTextStyle,
              ),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
        Spacer(),
        ElevatedButton(
          onPressed: showResult,
          child: Text(i18n.result),
        ),
        Spacer(),
      ],
    );
  }
}
