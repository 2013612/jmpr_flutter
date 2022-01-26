import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../models/game.dart';
import '../models/game_player.dart';
import '../models/point_setting.dart';
import '../pages/user_info/firestore_upload_input.dart';
import '../providers/games_provider.dart';
import '../utility/constant.dart';
import '../utility/iterable_methods.dart';
import 'base_bar_button.dart';

class ChooseGame extends ConsumerStatefulWidget {
  @override
  _ChooseGameState createState() => _ChooseGameState();
}

class _ChooseGameState extends ConsumerState<ChooseGame> {
  final List<Tuple2<int, int>> chosen = [];
  late final List<Tuple2<Tuple2<int, int>, PointSetting>> reversedPointSettings;

  @override
  void initState() {
    super.initState();
    reversedPointSettings = ref
        .read(gamesProvider)
        .mapIndexed((game, gIndex) => game.pointSettings.mapIndexed(
            (pointSetting, pIndex) =>
                Tuple2(Tuple2(gIndex, pIndex), pointSetting)))
        .fold<List<Tuple2<Tuple2<int, int>, PointSetting>>>(
            [], (previousValue, element) => [...previousValue, ...element])
        .reversed
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final List<Color> colors = [
      Colors.black26,
      Colors.black12,
    ];

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(i18n.chooseFirstAndLastRecords),
        ),
      ),
      body: ListView.builder(
        itemCount: reversedPointSettings.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(
                "${Constant.kyokus[reversedPointSettings[index].item2.currentKyoku]} - ${reversedPointSettings[index].item2.bonba}"),
            title: FittedBox(
              child: Text(
                reversedPointSettings[index].item2.players.entries.fold(
                    "",
                    (previousValue, player) =>
                        "$previousValue ${Constant.positionTexts[player.key]}: ${player.value.point}"),
              ),
            ),
            tileColor: colors[
                reversedPointSettings[index].item1.item1 % colors.length],
            selectedTileColor: colors[
                reversedPointSettings[index].item1.item1 % colors.length],
            dense: true,
            selected: chosen.contains(reversedPointSettings[index].item1),
            onTap: () {
              if (chosen.contains(reversedPointSettings[index].item1)) {
                setState(() {
                  chosen.remove(reversedPointSettings[index].item1);
                });
              } else {
                if (chosen.length == 2) {
                  return;
                } else {
                  setState(() {
                    chosen.add(reversedPointSettings[index].item1);
                  });
                }
              }
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BaseBarButton(
              name: i18n.cancel,
              onPress: () => Navigator.pop(context),
            ),
            BaseBarButton(
              name: i18n.next,
              onPress: () {
                if (chosen.length < 2) {
                  Fluttertoast.showToast(
                    msg: i18n.errorExactTwoRecords,
                    backgroundColor: Colors.red,
                  );
                  return;
                } else if (chosen[0].item1 != chosen[1].item1) {
                  Fluttertoast.showToast(
                    msg: i18n.errorDifferentGames,
                    backgroundColor: Colors.red,
                  );
                  return;
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FirestoreUploadInput(
                        Game(
                          gamePlayers: List.generate(
                              4, (_) => GamePlayer(displayName: '', uid: '')),
                          createdAt: DateTime.now(),
                          setting:
                              ref.watch(gamesProvider)[chosen[0].item1].setting,
                          transactions: ref
                              .watch(gamesProvider)[chosen[0].item1]
                              .transactions
                              .getRange(min(chosen[0].item2, chosen[1].item2),
                                  max(chosen[0].item2, chosen[1].item2))
                              .toList(),
                          pointSettings: ref
                              .watch(gamesProvider)[chosen[0].item1]
                              .pointSettings
                              .getRange(min(chosen[0].item2, chosen[1].item2),
                                  max(chosen[0].item2, chosen[1].item2) + 1)
                              .toList(),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
