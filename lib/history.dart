import 'package:flutter/material.dart';
import 'package:jmpr_flutter/common.dart';
import 'package:jmpr_flutter/pointSetting.dart';
import 'package:jmpr_flutter/setting.dart';

class HistoryPage extends StatelessWidget {
  static final ShapeBorder _shapeBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
  );
  List<History> histories;
  Function save;
  Constant constant;

  HistoryPage({
    @required this.histories,
    @required this.save,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("歷史"),
      ),
      body: ListView(
        children: histories.reversed
            .map((history) => ListTile(
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
                          title: Text("確認"),
                          content: Text("確定要回到這一局嗎?"),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("取消"),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                save(history);
                                Navigator.of(context).pop();
                              },
                              child: Text("確定"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ))
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
