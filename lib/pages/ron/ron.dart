import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common_widgets/base_bar_button.dart';
import '../../utility/enum/position.dart';
import 'local_widgets/ron_check_box_list_tile.dart';
import 'local_widgets/roned_player_radio_list_tile.dart';
import 'ron_point.dart';

class Ron extends StatefulWidget {
  @override
  State<Ron> createState() => _RonState();
}

class _RonState extends State<Ron> {
  Position _ronedPlayer = Position.bottom;
  final Map<Position, bool> _isRonPlayers = {};

  @override
  void initState() {
    super.initState();
    for (Position position in Position.values) {
      _isRonPlayers[position] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    void Function(bool?) checkBoxOnChanged(Position position) {
      return (bool? val) {
        setState(
          () {
            _isRonPlayers[position] = val ?? false;
          },
        );
      };
    }

    void radioOnChanged(Position? position) {
      setState(() {
        _ronedPlayer = position ?? Position.bottom;
      });
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(i18n.ron),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            shrinkWrap: true,
            children: [
              Text(i18n.lose),
              Row(
                children: [
                  RonedPlayerRadioListTile(
                    position: Position.bottom,
                    cur: _ronedPlayer,
                    onChanged: radioOnChanged,
                  ),
                  RonedPlayerRadioListTile(
                    position: Position.right,
                    cur: _ronedPlayer,
                    onChanged: radioOnChanged,
                  ),
                ],
              ),
              Row(
                children: [
                  RonedPlayerRadioListTile(
                    position: Position.top,
                    cur: _ronedPlayer,
                    onChanged: radioOnChanged,
                  ),
                  RonedPlayerRadioListTile(
                    position: Position.left,
                    cur: _ronedPlayer,
                    onChanged: radioOnChanged,
                  ),
                ],
              ),
              Text(i18n.win),
              Row(
                children: [
                  RonCheckBoxListTile(
                    position: Position.bottom,
                    checkBoxValue: _isRonPlayers[Position.bottom],
                    onChanged: checkBoxOnChanged(Position.bottom),
                  ),
                  RonCheckBoxListTile(
                    position: Position.right,
                    checkBoxValue: _isRonPlayers[Position.right],
                    onChanged: checkBoxOnChanged(Position.right),
                  ),
                ],
              ),
              Row(
                children: [
                  RonCheckBoxListTile(
                    position: Position.top,
                    checkBoxValue: _isRonPlayers[Position.top],
                    onChanged: checkBoxOnChanged(Position.top),
                  ),
                  RonCheckBoxListTile(
                    position: Position.left,
                    checkBoxValue: _isRonPlayers[Position.left],
                    onChanged: checkBoxOnChanged(Position.left),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
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
                  if (!_isRonPlayers.values
                      .reduce((value, element) => value || element)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(i18n.error),
                          content: Text(
                            i18n.errorAtLeastOneWin,
                          ),
                        );
                      },
                    );
                    return;
                  } else if (_isRonPlayers[_ronedPlayer]!) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(i18n.error),
                          content: Text(
                            i18n.errorSamePlayer,
                          ),
                        );
                      },
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RonPoint(
                        isRonPlayers: _isRonPlayers,
                        losePlayer: _ronedPlayer,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
