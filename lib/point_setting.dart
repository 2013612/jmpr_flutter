import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common.dart';

class PointSetting extends StatefulWidget {
  final PointSettingParameter currentPointSetting;
  final Function save;

  PointSetting({
    @required this.currentPointSetting,
    @required this.save,
  });

  @override
  _PointSettingState createState() => _PointSettingState();
}

class _PointSettingState extends State<PointSetting> {
  final _pointSettingFormKey = GlobalKey<FormState>();
  PointSettingParameter _currentPointSetting;
  Map<Position, TextEditingController> _positionControllers;
  TextEditingController _bonbaController, _riichibouController;

  @override
  void initState() {
    super.initState();
    _currentPointSetting = widget.currentPointSetting;
    _positionControllers = {};
    for (Position position in Position.values) {
      _positionControllers[position] = TextEditingController(
          text: _currentPointSetting.players[position].point.toString());
    }
    _bonbaController =
        TextEditingController(text: _currentPointSetting.bonba.toString());
    _riichibouController =
        TextEditingController(text: _currentPointSetting.riichibou.toString());
  }

  @override
  Widget build(BuildContext context) {
    final InputDecoration _inputDecoration = InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.all(8.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    // TODO: update validator function
    String _integerValidator(String input) {
      if (int.tryParse(input) == null || int.tryParse(input) % 100 != 0) {
        return AppLocalizations.of(context).errorDivideByHundred;
      }
      return null;
    }

    String _nonNegativeIntegerValidator(String input) {
      if (int.tryParse(input) == null || int.tryParse(input) < 0) {
        return AppLocalizations.of(context).errorNonnegative;
      }
      return null;
    }

    void copyPointSetting(PointSettingParameter pointSettingParameter) {
      for (Position position in Position.values) {
        _positionControllers[position].text =
            pointSettingParameter.players[position].point.toString();
      }
      _bonbaController.text = pointSettingParameter.bonba.toString();
      _riichibouController.text = pointSettingParameter.riichibou.toString();
    }

    Widget rowInput(String name, Widget widget, [IconData icon]) {
      Widget child;
      if (icon != null) {
        child = Row(
          children: [
            Text(name),
            Icon(icon),
          ],
        );
      } else {
        child = Text(name);
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            child: child,
          ),
          Container(
            width: 200,
            padding: EdgeInsets.all(8.0),
            child: widget,
          ),
        ],
      );
    }

    Widget textInput(void Function(String) save,
        TextEditingController controller, String Function(String) validator) {
      return TextFormField(
        keyboardType: TextInputType.numberWithOptions(signed: true),
        decoration: _inputDecoration,
        onSaved: save,
        controller: controller,
        validator: validator,
      );
    }

    Widget dropdownInput() {
      return DropdownButtonFormField<String>(
        items: Constant.kyokus
            .map((String kyoku) =>
                DropdownMenuItem<String>(value: kyoku, child: Text(kyoku)))
            .toList(),
        value: Constant.kyokus[_currentPointSetting.currentKyoku],
        decoration: _inputDecoration,
        onChanged: (String kyoku) {
          setState(() {
            _currentPointSetting.currentKyoku = Constant.kyokus.indexOf(kyoku);
          });
        },
        onSaved: (String kyoku) {
          _currentPointSetting.currentKyoku = Constant.kyokus.indexOf(kyoku);
        },
      );
    }

    Widget positionPointSetting(Position position) {
      return rowInput(
          Constant.positionTexts[position],
          textInput(
              (String point) => _currentPointSetting.players[position].point =
                  int.tryParse(point),
              _positionControllers[position],
              _integerValidator),
          Constant.arrows[position]);
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).pointSetting),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _pointSettingFormKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ...Position.values.map(positionPointSetting).toList(),
                  rowInput(
                    AppLocalizations.of(context).kyoku,
                    dropdownInput(),
                  ),
                  rowInput(
                    AppLocalizations.of(context).bonba,
                    textInput(
                        (String bonba) =>
                            _currentPointSetting.bonba = int.tryParse(bonba),
                        _bonbaController,
                        _nonNegativeIntegerValidator),
                  ),
                  rowInput(
                    AppLocalizations.of(context).kyoutaku,
                    textInput(
                        (String kyoutaku) => _currentPointSetting.riichibou =
                            int.tryParse(kyoutaku),
                        _riichibouController,
                        _nonNegativeIntegerValidator),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BaseBarButton(
                AppLocalizations.of(context).currentPointSetting,
                () => copyPointSetting(widget.currentPointSetting),
              ),
              BaseBarButton(
                AppLocalizations.of(context).cancel,
                () => Navigator.pop(context),
              ),
              BaseBarButton(
                AppLocalizations.of(context).save,
                () {
                  if (_pointSettingFormKey.currentState.validate()) {
                    _pointSettingFormKey.currentState.save();
                    widget.save(_currentPointSetting);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Player {
  Position position;
  int point;
  bool riichi;

  Player({this.position, this.point, this.riichi});

  Player clone() {
    return Player(
      position: position,
      point: point,
      riichi: riichi,
    );
  }
}

class PointSettingParameter {
  Map<Position, Player> players;
  int currentKyoku;
  int bonba;
  int riichibou;

  PointSettingParameter(
      {this.players, this.currentKyoku, this.bonba, this.riichibou});

  PointSettingParameter clone() {
    Map<Position, Player> newPlayers = {};
    players.forEach((key, value) {
      newPlayers[key] = value.clone();
    });
    return PointSettingParameter(
      players: newPlayers,
      currentKyoku: currentKyoku,
      bonba: bonba,
      riichibou: riichibou,
    );
  }
}
