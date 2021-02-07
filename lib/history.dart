import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jmpr_flutter/common.dart';
import 'package:jmpr_flutter/pointSetting.dart';
import 'package:jmpr_flutter/setting.dart';

class HistoryPage extends StatelessWidget {
  final List<History> histories;
  final Function goTo;

  HistoryPage({
    @required this.histories,
    @required this.goTo,
  });

  @override
  Widget build(BuildContext context) {
    final ShapeBorder _shapeBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).history),
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
                      title: Text(AppLocalizations.of(context).confirm),
                      content:
                      Text(AppLocalizations.of(context).confirmHistory),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(AppLocalizations.of(context).cancel),
                        ),
                        FlatButton(
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

class History {
  PointSettingParameter pointSetting;
  SettingParameter setting;

  History({this.pointSetting, this.setting});
}
