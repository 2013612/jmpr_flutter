import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../classes/history.dart';
import '../../common_widgets/base_bar_button.dart';
import '../../utility/constant.dart';
import 'local_widgets/user_input.dart';

class ChooseHistory extends StatefulWidget {
  final List<History> histories;
  final Function next;

  ChooseHistory({
    required this.histories,
    required this.next,
  });

  @override
  _ChooseHistoryState createState() => _ChooseHistoryState();
}

class _ChooseHistoryState extends State<ChooseHistory> {
  late List<int> chosen;
  late List<History> reversedHistories;

  @override
  void initState() {
    super.initState();
    chosen = [];
    reversedHistories = widget.histories.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final ShapeBorder _shapeBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    );

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
            shape: _shapeBorder,
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
                      backgroundColor: Colors.red);
                  return;
                } else if (!reversedHistories[chosen[0]]
                    .setting
                    .equal(reversedHistories[chosen[1]].setting)) {
                  Fluttertoast.showToast(
                      msg: i18n.errorSettingsAreDifferent,
                      backgroundColor: Colors.red);
                  return;
                } else {
                  chosen[0] = reversedHistories.length - 1 - chosen[0];
                  chosen[1] = reversedHistories.length - 1 - chosen[1];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserInput(
                        (String folder, String fileName, String sheetName,
                            Map<Position, String> playerNames) async {
                          bool success2 = true;
                          await widget
                              .next(
                                  min(chosen[0], chosen[1]),
                                  max(chosen[0], chosen[1]),
                                  folder,
                                  fileName,
                                  sheetName,
                                  playerNames)
                              .then((bool success) {
                            if (success) {
                              Navigator.pop(context);
                            } else {
                              success2 = false;
                            }
                          });
                          return success2;
                        },
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
