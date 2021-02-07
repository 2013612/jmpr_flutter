import 'package:flutter/material.dart';
import 'package:jmpr_flutter/ronPoint.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common.dart';

class Ron extends StatefulWidget {
  final Function next;

  Ron({this.next});

  @override
  State<Ron> createState() => _RonState();
}

class _RonState extends State<Ron> {
  Position _ronedPlayer;
  Map<Position, bool> _isRonPlayers;

  @override
  void initState() {
    super.initState();
    _ronedPlayer = Position.Bottom;
    _isRonPlayers = Map();
    Position.values.forEach((element) {
      _isRonPlayers[element] = false;
    });
  }

  Widget RonedPlayerRadioListTile(Position position) {
    return FlexibleCustomRadioTile(
      position,
      _ronedPlayer,
      Constant.positionTexts[position],
      (val) {
        setState(() {
          _ronedPlayer = val;
        });
      },
      Constant.arrows[position],
    );
  }

  Widget RonCheckboxListTile(Position position) {
    return FlexibleCustomCheckBoxTile(
      _isRonPlayers[position],
      Constant.positionTexts[position],
      (val) {
        setState(() {
          _isRonPlayers[position] = val;
        });
      },
      Constant.arrows[position],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).ron),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            shrinkWrap: true,
            children: [
              Text(AppLocalizations.of(context).lose),
              Row(
                children: [
                  RonedPlayerRadioListTile(Position.Bottom),
                  RonedPlayerRadioListTile(Position.Right),
                ],
              ),
              Row(
                children: [
                  RonedPlayerRadioListTile(Position.Top),
                  RonedPlayerRadioListTile(Position.Left),
                ],
              ),
              Text(AppLocalizations.of(context).win),
              Row(
                children: [
                  RonCheckboxListTile(Position.Bottom),
                  RonCheckboxListTile(Position.Right),
                ],
              ),
              Row(
                children: [
                  RonCheckboxListTile(Position.Top),
                  RonCheckboxListTile(Position.Left),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BaseBarButton(AppLocalizations.of(context).cancel,
                  () => Navigator.pop(context)),
              BaseBarButton(AppLocalizations.of(context).next, () {
                if (!_isRonPlayers.values
                    .reduce((value, element) => value || element)) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(AppLocalizations.of(context).error),
                          content: Text(
                              AppLocalizations.of(context).errorAtLeastOneWin),
                        );
                      });
                  return;
                } else if (_isRonPlayers[_ronedPlayer]) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(AppLocalizations.of(context).error),
                          content: Text(
                              AppLocalizations.of(context).errorSamePlayer),
                        );
                      });
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RonPoint(
                      isRonPlayers: _isRonPlayers,
                      save: (Map<Position, int> hans, Map<Position, int> fus) {
                        widget.next(_ronedPlayer, _isRonPlayers, hans, fus);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}
