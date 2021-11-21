import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../classes/history.dart';
import '../../../classes/point_setting.dart';
import '../../../classes/setting.dart';
import '../../../utility/constant.dart';
import '../../../utility/providers.dart';
import 'point_riichi_display.dart';

class MainLandscape extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = AppLocalizations.of(context)!;
    var pointSetting = ref.watch(pointSettingProvider);
    final histories = ref.watch(historyProvider);
    final Color _textColor = Colors.white;

    Map<Position, double> calResult(History history) {
      final PointSetting _pointSetting = history.pointSetting;
      final Setting _setting = history.setting;
      List<List<int>> cal = [];
      Position position(int index) {
        return Position.values[(_setting.firstOya.index + cal[index][1]) % 4];
      }

      for (Position position in Position.values) {
        cal.add([
          _pointSetting.players[position]!.point - _setting.startingPoint,
          (Position.values.indexOf(position) -
                  Position.values.indexOf(_setting.firstOya) +
                  4) %
              4,
        ]);
      }

      cal.sort((List<int> a, List<int> b) {
        if (a[0] == b[0]) {
          return a[1] - b[1];
        } else {
          return b[0] - a[0];
        }
      });

      Map<Position, double> marks = {};
      double topBonus =
          4 * (_setting.startingPoint - _setting.givenStartingPoint) / 1000;
      if (_setting.isDouten) {
        if (cal[0][0] == cal[1][0] &&
            cal[1][0] == cal[2][0] &&
            cal[2][0] == cal[3][0]) {
          marks[position(0)] = cal[0][0] / 1000 + topBonus / 4;
          marks[position(1)] = cal[1][0] / 1000 + topBonus / 4;
          marks[position(2)] = cal[2][0] / 1000 + topBonus / 4;
          marks[position(3)] = cal[3][0] / 1000 + topBonus / 4;
        } else if (cal[0][0] == cal[1][0] && cal[1][0] == cal[2][0]) {
          marks[position(0)] =
              cal[0][0] / 1000 + (topBonus + _setting.umaBig) / 3;
          marks[position(1)] =
              cal[1][0] / 1000 + (topBonus + _setting.umaBig) / 3;
          marks[position(2)] =
              cal[2][0] / 1000 + (topBonus + _setting.umaBig) / 3;
          marks[position(3)] = cal[3][0] / 1000 - _setting.umaBig;
        } else if (cal[1][0] == cal[2][0] && cal[2][0] == cal[3][0]) {
          marks[position(0)] = cal[0][0] / 1000 + topBonus + _setting.umaBig;
          marks[position(1)] = cal[1][0] / 1000 - _setting.umaBig / 3;
          marks[position(2)] = cal[2][0] / 1000 - _setting.umaBig / 3;
          marks[position(3)] = cal[3][0] / 1000 - _setting.umaBig / 3;
        } else if (cal[0][0] == cal[1][0] && cal[2][0] == cal[3][0]) {
          marks[position(0)] = cal[0][0] / 1000 +
              (topBonus + _setting.umaBig + _setting.umaSmall) / 2;
          marks[position(1)] = cal[1][0] / 1000 +
              (topBonus + _setting.umaBig + _setting.umaSmall) / 2;
          marks[position(2)] =
              cal[2][0] / 1000 - (_setting.umaBig + _setting.umaSmall) / 2;
          marks[position(3)] =
              cal[3][0] / 1000 - (_setting.umaBig + _setting.umaSmall) / 2;
        } else if (cal[0][0] == cal[1][0]) {
          marks[position(0)] = cal[0][0] / 1000 +
              (topBonus + _setting.umaBig + _setting.umaSmall) / 2;
          marks[position(1)] = cal[1][0] / 1000 +
              (topBonus + _setting.umaBig + _setting.umaSmall) / 2;
          marks[position(2)] = cal[2][0] / 1000 - _setting.umaSmall;
          marks[position(3)] = cal[3][0] / 1000 - _setting.umaBig;
        } else if (cal[1][0] == cal[2][0]) {
          marks[position(0)] = cal[0][0] / 1000 + topBonus + _setting.umaBig;
          marks[position(1)] = cal[1][0] / 1000;
          marks[position(2)] = cal[2][0] / 1000;
          marks[position(3)] = cal[3][0] / 1000 - _setting.umaBig;
        } else if (cal[2][0] == cal[3][0]) {
          marks[position(0)] = cal[0][0] / 1000 + topBonus + _setting.umaBig;
          marks[position(1)] = cal[1][0] / 1000 + _setting.umaSmall;
          marks[position(2)] =
              cal[2][0] / 1000 - (_setting.umaBig + _setting.umaSmall) / 2;
          marks[position(3)] =
              cal[3][0] / 1000 - (_setting.umaBig + _setting.umaSmall) / 2;
        } else {
          marks[position(0)] = cal[0][0] / 1000 + topBonus + _setting.umaBig;
          marks[position(1)] = cal[1][0] / 1000 + _setting.umaSmall;
          marks[position(2)] = cal[2][0] / 1000 - _setting.umaSmall;
          marks[position(3)] = cal[3][0] / 1000 - _setting.umaBig;
        }
      } else {
        marks[position(0)] = cal[0][0] / 1000 + topBonus + _setting.umaBig;
        marks[position(1)] = cal[1][0] / 1000 + _setting.umaSmall;
        marks[position(2)] = cal[2][0] / 1000 - _setting.umaSmall;
        marks[position(3)] = cal[3][0] / 1000 - _setting.umaBig;
      }
      return marks;
    }

    void showResult() {
      Map<Position, double> marks = calResult(histories.last);

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
                style: TextStyle(
                  color: _textColor,
                  fontSize: 20.0,
                ),
              ),
              Spacer(),
              Text(
                "${pointSetting.bonba} 本場",
                style: TextStyle(
                  color: _textColor,
                  fontSize: 20.0,
                ),
              ),
              Spacer(),
              Text(
                "供托: ${pointSetting.riichibou}",
                style: TextStyle(
                  color: _textColor,
                  fontSize: 20.0,
                ),
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
