import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common.dart';
import 'ronPoint.dart';

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
    _isRonPlayers = {};
    for (Position position in Position.values) {
      _isRonPlayers[position] = false;
    }
  }

  Widget ronedPlayerRadioListTile(Position position) {
    return FlexibleCustomRadioTile(
      position,
      _ronedPlayer,
      Constant.positionTexts[position],
      (Position val) {
        setState(() {
          _ronedPlayer = val;
        });
      },
      Constant.arrows[position],
    );
  }

  Widget ronCheckboxListTile(Position position) {
    return FlexibleCustomCheckBoxTile(
      _isRonPlayers[position],
      Constant.positionTexts[position],
      (bool val) {
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
                  ronedPlayerRadioListTile(Position.Bottom),
                  ronedPlayerRadioListTile(Position.Right),
                ],
              ),
              Row(
                children: [
                  ronedPlayerRadioListTile(Position.Top),
                  ronedPlayerRadioListTile(Position.Left),
                ],
              ),
              Text(AppLocalizations.of(context).win),
              Row(
                children: [
                  ronCheckboxListTile(Position.Bottom),
                  ronCheckboxListTile(Position.Right),
                ],
              ),
              Row(
                children: [
                  ronCheckboxListTile(Position.Top),
                  ronCheckboxListTile(Position.Left),
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
                          AppLocalizations.of(context).errorAtLeastOneWin,
                        ),
                      );
                    },
                  );
                  return;
                } else if (_isRonPlayers[_ronedPlayer]) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(AppLocalizations.of(context).error),
                        content: Text(
                          AppLocalizations.of(context).errorSamePlayer,
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
        ),
      ),
    );
  }
}
