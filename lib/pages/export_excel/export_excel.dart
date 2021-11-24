import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jmpr_flutter/classes/history.dart';

import '../../common_widgets/base_bar_button.dart';
import '../../providers/histories.dart';
import '../../utility/constant.dart';
import 'user_input.dart';

class ChooseHistory extends ConsumerStatefulWidget {
  @override
  _ChooseHistoryState createState() => _ChooseHistoryState();
}

class _ChooseHistoryState extends ConsumerState<ChooseHistory> {
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
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
                } else if (!reversedHistories[chosen[0]]
                    .setting
                    .equal(reversedHistories[chosen[1]].setting)) {
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
