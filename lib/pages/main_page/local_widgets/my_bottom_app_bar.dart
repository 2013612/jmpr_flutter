import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jmpr_flutter/classes/history.dart';
import 'package:jmpr_flutter/utility/constant.dart';
import 'package:jmpr_flutter/utility/providers.dart';

import '../../../common_widgets/base_bar_button.dart';
import '../../ron/ron.dart';
import '../../ryukyoku/ryukyoku.dart';
import '../../tsumo/tsumo.dart';

class MyBottomAppBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i18n = AppLocalizations.of(context)!;
    var setting = ref.watch(settingProvider).state;
    var pointSetting = ref.watch(pointSettingProvider).state;
    var index = ref.watch(historyIndexProvider).state;
    final histories = ref.watch(historyProvider);

    Position currentOya() {
      return Position
          .values[(setting.firstOya.index + pointSetting.currentKyoku) % 4];
    }

    void setRiichiFalse() {
      for (Position position in Position.values) {
        pointSetting.players[position]!.riichi = false;
      }
    }

    void addHistory() {
      if (index < histories.length) {
        histories.removeRange(index, histories.length);
      }
      histories.add(
        History(
          pointSetting: ref.watch(pointSettingProvider).state.clone(),
          setting: ref.watch(settingProvider).state.clone(),
        ),
      );
      index++;
    }

    int calPoint(int han, int fu) {
      int point = (pow(2, han + 2) * fu).toInt();
      if (point > 1920) {
        point = Constant.points[han]!;
      } else if (point == 1920 && setting.isKiriage) {
        point = 2000;
      }
      return point;
    }

    void reset() {
      for (Position position in Position.values) {
        pointSetting.players[position]!.riichi = false;
        pointSetting.players[position]!.point = setting.givenStartingPoint;
      }
      pointSetting.currentKyoku = 0;
      pointSetting.bonba = 0;
      pointSetting.riichibou = 0;
      addHistory();
    }

    void updatePlayerPointTsumo(int point, Position position) {
      Position oya = currentOya();
      if (position == oya) {
        point *= 2;
      }
      pointSetting.players.forEach((key, value) {
        if (key == position) {
          if (key == oya) {
            value.point += (point + 99) ~/ 100 * 100 * 3 +
                pointSetting.bonba * setting.bonbaPoint +
                pointSetting.riichibou * setting.riichibouPoint;
          } else {
            value.point += (point + 99) ~/ 100 * 100 * 2 +
                (point * 2 + 99) ~/ 100 * 100 +
                pointSetting.bonba * setting.bonbaPoint +
                pointSetting.riichibou * setting.riichibouPoint;
          }
        } else {
          if (key == oya) {
            value.point -= (point * 2 + 99) ~/ 100 * 100 +
                pointSetting.bonba * setting.bonbaPoint ~/ 3;
          } else {
            value.point -= (point + 99) ~/ 100 * 100 +
                pointSetting.bonba * setting.bonbaPoint ~/ 3;
          }
        }
      });
      if (position != oya) {
        pointSetting.bonba = 0;
      }

      pointSetting.riichibou = 0;
    }

    void saveTsumo(Position tsumoPlayer, int han, int fu) {
      int point = calPoint(han, fu);
      Position oya = currentOya();
      updatePlayerPointTsumo(point, tsumoPlayer);
      if (tsumoPlayer == oya) {
        pointSetting.bonba++;
      } else {
        pointSetting.bonba = 0;
        pointSetting.currentKyoku = (pointSetting.currentKyoku + 1) % 16;
      }
      addHistory();
      setRiichiFalse();
    }

    void saveRon(Position ronedPlayer, Map<Position, bool> ronPlayers,
        Map<Position, int> hans, Map<Position, int> fus) {
      Position oya = currentOya();
      int nearIndex = 100;
      ronPlayers.forEach((key, value) {
        if (value) {
          int point = calPoint(hans[key]!, fus[key]!);
          if (key == oya) {
            point = (point * 6 + 99) ~/ 100 * 100;
          } else {
            point = (point * 4 + 99) ~/ 100 * 100;
          }
          pointSetting.players[key]!.point += point;
          pointSetting.players[ronedPlayer]!.point -= point;
          nearIndex =
              min(nearIndex, ((key.index - ronedPlayer.index) + 4) % 4);
        }
      });
      nearIndex = (nearIndex + ronedPlayer.index) % 4;
      pointSetting.players[ronedPlayer]!.point -=
          pointSetting.bonba * setting.bonbaPoint;
      pointSetting.players[Position.values[nearIndex]]!.point +=
          pointSetting.bonba * setting.bonbaPoint +
              pointSetting.riichibou * setting.riichibouPoint;
      pointSetting.riichibou = 0;
      if (ronPlayers[oya]!) {
        pointSetting.bonba++;
      } else {
        pointSetting.bonba = 0;
        pointSetting.currentKyoku = (pointSetting.currentKyoku + 1) % 16;
      }
      addHistory();
      setRiichiFalse();
    }

    void saveRyukyoku(
        Map<Position, bool> tenpai, Map<Position, bool> nagashimangan) {
      int numOfTenpai = 0;
      int numOfNagashimagan = 0;
      tenpai.forEach((key, value) {
        if (value) numOfTenpai++;
      });
      nagashimangan.forEach((key, value) {
        if (value) numOfNagashimagan++;
      });
      Position oya = currentOya();
      if (numOfNagashimagan > 0) {
        int? bonba = pointSetting.bonba;
        int? riichibou = pointSetting.riichibou;
        pointSetting.bonba = 0;
        pointSetting.riichibou = 0;
        nagashimangan.forEach((key, value) {
          if (value) {
            updatePlayerPointTsumo(2000, key);
          }
        });
        pointSetting.bonba = bonba;
        pointSetting.riichibou = riichibou;
      } else {
        if (numOfTenpai != 0 && numOfTenpai != 4) {
          tenpai.forEach((key, value) {
            if (value) {
              pointSetting.players[key]!.point +=
                  setting.ryukyokuPoint ~/ numOfTenpai;
            } else {
              pointSetting.players[key]!.point -=
                  setting.ryukyokuPoint ~/ (4 - numOfTenpai);
            }
          });
        }
      }
      if (!tenpai[oya]!) {
        pointSetting.currentKyoku = (pointSetting.currentKyoku + 1) % 16;
      }
      pointSetting.bonba++;
      addHistory();
      setRiichiFalse();
    }

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BaseBarButton(
              name: i18n.ron,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Ron(next: saveRon)));
              }),
          BaseBarButton(
              name: i18n.tsumo,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Tsumo(save: saveTsumo)));
              }),
          BaseBarButton(
              name: i18n.ryukyoku,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Ryukyoku(save: saveRyukyoku)));
              }),
          BaseBarButton(
            name: i18n.reset,
            onPress: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: Text(i18n.confirm),
                  content: Text(i18n.confirmReset),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(i18n.cancel),
                    ),
                    TextButton(
                      onPressed: () {
                        reset();
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
