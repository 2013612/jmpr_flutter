import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../classes/history.dart';
import '../pages/export_excel/user_input.dart';
import '../providers/histories.dart';
import '../utility/constant.dart';
import 'base_bar_button.dart';

class ChooseGame extends ConsumerStatefulWidget {
  @override
  _ChooseGameState createState() => _ChooseGameState();
}

class _ChooseGameState extends ConsumerState<ChooseGame> {
  final List<int> chosen = [];
  late final List<History> reversedHistories;

  @override
  void initState() {
    super.initState();
    reversedHistories = ref.read(historiesProvider).reversed.toList();
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
                "${Constant.kyokus[reversedHistories[index].pointSetting.currentKyoku]} - ${reversedHistories[index].pointSetting.bonba}"),
            title: FittedBox(
              child: Text(
                reversedHistories[index].pointSetting.players.entries.fold(
                    "",
                    (previousValue, player) =>
                        "$previousValue ${Constant.positionTexts[player.key]}: ${player.value.point}"),
              ),
            ),
            tileColor: colors[reversedHistories[index].index % colors.length],
            selectedTileColor:
                colors[reversedHistories[index].index % colors.length],
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(50.0),
            // ),
            dense: true,
            selected: chosen.contains(index),
            onTap: () {
              if (chosen.contains(index)) {
                setState(() {
                  chosen.remove(index);
                });
              } else {
                if (chosen.length == 2) {
                  return;
                } else {
                  setState(() {
                    chosen.add(index);
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
                } else if (reversedHistories[chosen[0]].index !=
                    reversedHistories[chosen[1]].index) {
                  Fluttertoast.showToast(
                    msg: i18n.errorSettingsAreDifferent,
                    backgroundColor: Colors.red,
                  );
                  return;
                } else {
                  chosen[0] = reversedHistories.length - 1 - chosen[0];
                  chosen[1] = reversedHistories.length - 1 - chosen[1];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserInput(
                        min(chosen[0], chosen[1]),
                        max(chosen[0], chosen[1]),
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
