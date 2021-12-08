import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/histories.dart';
import '../../../utility/constant.dart';
import '../../../utility/enum/position.dart';
import 'point_riichi_display.dart';

class MainLandscape extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = AppLocalizations.of(context)!;
    final histories = ref.watch(historiesProvider);
    final index = ref.watch(historyIndexProvider);
    final pointSetting = histories[index].pointSetting;
    final middleTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    );

    void showResult() {
      Map<Position, double> marks = histories[index].calResult();

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
