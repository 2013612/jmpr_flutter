import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../classes/history.dart';
import '../../utility/constant.dart';

class HistoryPage extends StatelessWidget {
  final List<History> histories;
  final Function goTo;

  HistoryPage({
    required this.histories,
    required this.goTo,
  });

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
      body: ListView(
        children: histories.reversed
            .map(
              (history) => ListTile(
                leading: Text(
                    "${Constant.kyokus[history.pointSetting.currentKyoku]} - ${history.pointSetting.bonba}"),
                title: FittedBox(
                  child: Text(
                    history.pointSetting.players.entries.fold(
                        "",
                        (previousValue, player) =>
                            "$previousValue ${Constant.positionTexts[player.key]}: ${player.value.point}"),
                  ),
                ),
                shape: _shapeBorder,
                dense: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(i18n.confirm),
                        content: Text(i18n.confirmHistory),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(i18n.cancel),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              goTo(history);
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
