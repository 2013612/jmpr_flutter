import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common.dart';
import 'common_widgets/base_bar_button.dart';
import 'common_widgets/custom_check_box_tile.dart';
import 'common_widgets/custom_radio_tile.dart';
import 'ron_point.dart';

class Ron extends StatefulWidget {
  final Function next;

  Ron({required this.next});

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

  Widget ronedPlayerRadioListTile(Position position) {
    return Flexible(
      child: CustomRadioTile(
        value: position,
        cur: _ronedPlayer,
        title: Constant.positionTexts[position]!,
        onChanged: (Position? val) {
          setState(() {
            _ronedPlayer = val ?? Position.bottom;
          });
        },
        icon: Constant.arrows[position]!,
      ),
    );
  }

  Widget ronCheckboxListTile(Position position) {
    return Flexible(
      child: CustomCheckBoxTile(
        checkBoxValue: _isRonPlayers[position]!,
        title: Constant.positionTexts[position]!,
        onChanged: (bool? val) {
          setState(() {
            _isRonPlayers[position] = val ?? false;
          });
        },
        icon: Constant.arrows[position],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
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
                  ronedPlayerRadioListTile(Position.bottom),
                  ronedPlayerRadioListTile(Position.right),
                ],
              ),
              Row(
                children: [
                  ronedPlayerRadioListTile(Position.top),
                  ronedPlayerRadioListTile(Position.left),
                ],
              ),
              Text(i18n.win),
              Row(
                children: [
                  ronCheckboxListTile(Position.bottom),
                  ronCheckboxListTile(Position.right),
                ],
              ),
              Row(
                children: [
                  ronCheckboxListTile(Position.top),
                  ronCheckboxListTile(Position.left),
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
                  name: i18n.cancel, onPress: () => Navigator.pop(context)),
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
                          save: (Map<Position, int> hans,
                              Map<Position, int> fus) {
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
