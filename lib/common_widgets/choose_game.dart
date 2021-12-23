import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../classes/history.dart';
import '../pages/user_info/firestore_upload_input.dart';
import '../providers/games.dart';
import '../utility/constant.dart';
import '../utility/iterable_methods.dart';
import 'base_bar_button.dart';

class ChooseGame extends ConsumerStatefulWidget {
  @override
  _ChooseGameState createState() => _ChooseGameState();
}

class _ChooseGameState extends ConsumerState<ChooseGame> {
  final List<Tuple2<int, int>> chosen = [];
  late final List<Tuple2<Tuple2<int, int>, History>> reversedHistories;

  @override
  void initState() {
    super.initState();
    reversedHistories = ref
        .read(gamesProvider)
        .mapIndexed((game, gIndex) => game.histories.mapIndexed(
            (history, hIndex) => Tuple2(Tuple2(gIndex, hIndex), history)))
        .fold<List<Tuple2<Tuple2<int, int>, History>>>(
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
        title: Text(i18n.history),
      ),
      body: ListView.builder(
        itemCount: reversedHistories.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(
                "${Constant.kyokus[reversedHistories[index].item2.pointSetting.currentKyoku]} - ${reversedHistories[index].item2.pointSetting.bonba}"),
            title: FittedBox(
              child: Text(
                reversedHistories[index].item2.pointSetting.players.entries.fold(
                    "",
                    (previousValue, player) =>
                        "$previousValue ${Constant.positionTexts[player.key]}: ${player.value.point}"),
              ),
            ),
            tileColor:
                colors[reversedHistories[index].item1.item1 % colors.length],
            selectedTileColor:
                colors[reversedHistories[index].item1.item1 % colors.length],
            dense: true,
            selected: chosen.contains(reversedHistories[index].item1),
            onTap: () {
              if (chosen.contains(reversedHistories[index].item1)) {
                setState(() {
                  chosen.remove(reversedHistories[index].item1);
                });
              } else {
                if (chosen.length == 2) {
                  return;
                } else {
                  setState(() {
                    chosen.add(reversedHistories[index].item1);
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
                    msg: i18n.errorSettingsAreDifferent,
                    backgroundColor: Colors.red,
                  );
                  return;
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FirestoreUploadInput(
                        ref.watch(gamesProvider)[chosen[0].item1],
                        min(chosen[0].item2, chosen[1].item2),
                        max(chosen[0].item2, chosen[1].item2),
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
