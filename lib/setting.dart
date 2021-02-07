import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common.dart';

class Setting extends StatefulWidget {
  final SettingParameter currentSetting;
  final Function save;

  Setting({
    @required this.currentSetting,
    @required this.save,
  });

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _settingFormKey = GlobalKey<FormState>();
  SettingParameter _editingSetting;
  final SettingParameter _tenhouSetting = SettingParameter(
    startingPoint: 30000,
    givenStartingPoint: 25000,
    riichibouPoint: 1000,
    bonbaPoint: 300,
    ryukyokuPoint: 3000,
    umaBig: 20,
    umaSmall: 10,
    isKiriage: false,
    isDouten: false,
    firstOya: Position.Bottom,
  );
  final SettingParameter _RMUSetting = SettingParameter(
    startingPoint: 30000,
    givenStartingPoint: 30000,
    riichibouPoint: 1000,
    bonbaPoint: 300,
    ryukyokuPoint: 3000,
    umaBig: 30,
    umaSmall: 10,
    isKiriage: true,
    isDouten: true,
    firstOya: Position.Bottom,
  );
  final InputDecoration _inputDecoration = InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.all(8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
  TextEditingController _givenStartingPointController,
      _startingPointController,
      _riichibouPointController,
      _bonbaPointController,
      _ryukyokuPointController,
      _umaBigController,
      _umaSmallController;

  static final ShapeBorder _shapeBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
  );

  @override
  void initState() {
    super.initState();
    _editingSetting = widget.currentSetting ?? _tenhouSetting;
    _givenStartingPointController = TextEditingController(
        text: _editingSetting.givenStartingPoint.toString());
    _startingPointController =
        TextEditingController(text: _editingSetting.startingPoint.toString());
    _riichibouPointController =
        TextEditingController(text: _editingSetting.riichibouPoint.toString());
    _bonbaPointController =
        TextEditingController(text: _editingSetting.bonbaPoint.toString());
    _ryukyokuPointController =
        TextEditingController(text: _editingSetting.ryukyokuPoint.toString());
    _umaBigController =
        TextEditingController(text: _editingSetting.umaBig.toString());
    _umaSmallController =
        TextEditingController(text: _editingSetting.umaSmall.toString());
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> _usualSettings = {
      "currentSetting": AppLocalizations.of(context).currentSetting,
      "RMU A/B RULE": AppLocalizations.of(context).rmu,
      "tenhou": AppLocalizations.of(context).tenhou
    };

    // TODO: update validator function
    String _defaultValidator(String input) {
      if (int.tryParse(input) == null) {
        return AppLocalizations.of(context).errorInteger;
      }
      return null;
    }

    String _umaValidator(_) {
      if (int.tryParse(_umaBigController.text) == null ||
          int.tryParse(_umaSmallController.text) == null) {
        return AppLocalizations.of(context).errorInteger;
      } else if (int.tryParse(_umaBigController.text) <
          int.tryParse(_umaSmallController.text)) {
        return AppLocalizations.of(context).errorDecreasing;
      }
      return null;
    }

    void copySetting(SettingParameter setting) {
      _givenStartingPointController.text =
          setting.givenStartingPoint.toString();
      _startingPointController.text = setting.startingPoint.toString();
      _riichibouPointController.text = setting.riichibouPoint.toString();
      _bonbaPointController.text = setting.bonbaPoint.toString();
      _ryukyokuPointController.text = setting.ryukyokuPoint.toString();
      _umaBigController.text = setting.umaBig.toString();
      _umaSmallController.text = setting.umaSmall.toString();
    }

    Widget RowInput(String name, Widget widget) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            child: Text(
              name + ":",
            ),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.all(8.0),
            child: widget,
          ),
        ],
      );
    }


    Widget TextInput(Function save, TextEditingController controller,
        [Function validator]) {
      validator ??= _defaultValidator;
      return TextFormField(
        keyboardType: TextInputType.numberWithOptions(signed: true),
        decoration: _inputDecoration,
        onSaved: save,
        controller: controller,
        validator: validator,
      );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).setting),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _settingFormKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  RowInput(
                      AppLocalizations.of(context).startingPoint,
                      TextInput(
                          (String startingPoint) => _editingSetting
                              .startingPoint = int.tryParse(startingPoint),
                          _startingPointController)),
                  RowInput(
                      AppLocalizations.of(context).givenStartingPoint,
                      TextInput(
                          (String givenStartingPoint) =>
                              _editingSetting.givenStartingPoint =
                                  int.tryParse(givenStartingPoint),
                          _givenStartingPointController)),
                  RowInput(
                      AppLocalizations.of(context).riichibouPoint,
                      TextInput(
                          (String riichibouPoint) => _editingSetting
                              .riichibouPoint = int.tryParse(riichibouPoint),
                          _riichibouPointController)),
                  RowInput(
                      AppLocalizations.of(context).bonbaPoint,
                      TextInput(
                          (String bonbaPoint) => _editingSetting.bonbaPoint =
                              int.tryParse(bonbaPoint),
                          _bonbaPointController)),
                  RowInput(
                      AppLocalizations.of(context).ryukyokuPoint,
                      TextInput(
                          (String ryukyokuPoint) => _editingSetting
                              .ryukyokuPoint = int.tryParse(ryukyokuPoint),
                          _ryukyokuPointController)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          AppLocalizations.of(context).uma + ":",
                        ),
                      ),
                      Container(
                        width: 100,
                        padding: EdgeInsets.all(8.0),
                        child: TextInput(
                                (String umaBig) =>
                                _editingSetting.umaBig = int.tryParse(umaBig),
                            _umaBigController,
                            _umaValidator),
                      ),
                      Container(
                        width: 100,
                        padding: EdgeInsets.all(8.0),
                        child: TextInput(
                            (String umaSmall) => _editingSetting.umaSmall =
                                int.tryParse(umaSmall),
                            _umaSmallController,
                            _umaValidator),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child:
                            Text(AppLocalizations.of(context).firstOya + ":"),
                      ),
                      Container(
                        width: 200,
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<Position>(
                          items: Constant.positionTexts.entries
                              .map((positionText) => DropdownMenuItem<Position>(
                                  child: Text(positionText.value),
                                  value: positionText.key))
                              .toList(),
                          value: _editingSetting.firstOya,
                          decoration: _inputDecoration,
                          onChanged: (Position firstOya) {
                            setState(() {
                              _editingSetting.firstOya = firstOya;
                            });
                          },
                          onSaved: (Position firstOya) {
                            _editingSetting.firstOya = firstOya;
                          },
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: SizedBox(
                      width: 350.0,
                      child: CustomCheckBoxTile(_editingSetting.isKiriage,
                          AppLocalizations.of(context).kiriage,
                          (bool isKiriage) {
                        setState(() {
                          _editingSetting.isKiriage = isKiriage;
                        });
                      }),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 350.0,
                      child: CustomCheckBoxTile(_editingSetting.isDouten,
                          AppLocalizations.of(context).samePoint,
                          (bool isDouten) {
                        setState(() {
                          _editingSetting.isDouten = isDouten;
                        });
                      }),
                    ),
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
              // This RaisedButton is used just for the size and shape, does not used as a button
              RaisedButton(
                onPressed: () {},
                textColor: Colors.black,
                color: Colors.white,
                elevation: 0.0,
                shape: _shapeBorder,
                child: PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) {
                    return _usualSettings.entries.map((setting) {
                      return PopupMenuItem<String>(
                        value: setting.key,
                        child: Text(setting.value),
                      );
                    }).toList();
                  },
                  child: Text(AppLocalizations.of(context).usualSetting),
                  onSelected: (setting) {
                    switch (setting) {
                      case "currentSetting":
                        setState(() {
                          _editingSetting = widget.currentSetting;
                          copySetting(widget.currentSetting);
                        });
                        break;
                      case "RMU A/B RULE":
                        setState(() {
                          _editingSetting = _RMUSetting;
                          copySetting(_RMUSetting);
                        });
                        break;
                      case "tenhou":
                        setState(() {
                          _editingSetting = _tenhouSetting;
                          copySetting(_tenhouSetting);
                        });
                        break;
                    }
                  },
                ),
              ),
              BaseBarButton(AppLocalizations.of(context).cancel,
                  () => Navigator.pop(context)),
              BaseBarButton(AppLocalizations.of(context).save, () {
                if (_settingFormKey.currentState.validate()) {
                  _settingFormKey.currentState.save();
                  widget.save(_editingSetting);
                  Navigator.pop(context);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingParameter {
  int givenStartingPoint;
  int startingPoint;
  int riichibouPoint;
  int bonbaPoint;
  int ryukyokuPoint;
  int umaSmall;
  int umaBig;
  bool isKiriage;
  bool isDouten;
  Position firstOya;

  SettingParameter({
    this.givenStartingPoint,
    this.startingPoint,
    this.riichibouPoint,
    this.bonbaPoint,
    this.ryukyokuPoint,
    this.umaBig,
    this.umaSmall,
    this.isKiriage,
    this.isDouten,
    this.firstOya,
  });

  SettingParameter clone() {
    return SettingParameter(
      givenStartingPoint: givenStartingPoint,
      startingPoint: startingPoint,
      riichibouPoint: riichibouPoint,
      bonbaPoint: bonbaPoint,
      ryukyokuPoint: ryukyokuPoint,
      umaBig: umaBig,
      umaSmall: umaSmall,
      isKiriage: isKiriage,
      isDouten: isDouten,
      firstOya: firstOya,
    );
  }

  bool equal(SettingParameter other) {
    return givenStartingPoint == other.givenStartingPoint &&
        startingPoint == other.startingPoint &&
        riichibouPoint == other.riichibouPoint &&
        bonbaPoint == other.bonbaPoint &&
        ryukyokuPoint == other.ryukyokuPoint &&
        umaBig == other.umaBig &&
        umaSmall == other.umaSmall &&
        isKiriage == other.isKiriage &&
        isDouten == other.isDouten &&
        firstOya == other.firstOya;
  }
}
