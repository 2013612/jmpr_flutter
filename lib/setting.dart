import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common.dart';

class Setting extends StatefulWidget {
  SettingParameter currentSetting;
  Function save;
  Position firstOya;

  Setting({
    @required this.currentSetting,
    @required this.save,
    @required this.firstOya,
  });

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _settingFormKey = GlobalKey<FormState>();
  SettingParameter currentSetting;
  Position firstOya;
  final SettingParameter _tenhouSetting = SettingParameter(
    startingPoint: 30000,
    givenStartingPoint: 25000,
    riichibouPoint: 1000,
    bonbaPoint: 300,
    ryukyokuPoint: 3000,
    umaBig: 20,
    umaSmall: 10,
    kiriage: false,
    douten: false,
  );
  final SettingParameter _RMUSetting = SettingParameter(
    startingPoint: 30000,
    givenStartingPoint: 30000,
    riichibouPoint: 1000,
    bonbaPoint: 300,
    ryukyokuPoint: 3000,
    umaBig: 30,
    umaSmall: 10,
    kiriage: true,
    douten: true,
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
    currentSetting = widget.currentSetting ?? _tenhouSetting;
    firstOya = widget.firstOya;
    _givenStartingPointController = TextEditingController(
        text: currentSetting.givenStartingPoint.toString());
    _startingPointController =
        TextEditingController(text: currentSetting.startingPoint.toString());
    _riichibouPointController =
        TextEditingController(text: currentSetting.riichibouPoint.toString());
    _bonbaPointController =
        TextEditingController(text: currentSetting.bonbaPoint.toString());
    _ryukyokuPointController =
        TextEditingController(text: currentSetting.ryukyokuPoint.toString());
    _umaBigController =
        TextEditingController(text: currentSetting.umaBig.toString());
    _umaSmallController =
        TextEditingController(text: currentSetting.umaSmall.toString());
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> _usualSettings = {
      "currentSetting": AppLocalizations.of(context).currentSetting,
      "RMU A/B RULE": AppLocalizations.of(context).rmu,
      "tenhou": AppLocalizations.of(context).tenhou
    };
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

    // TODO: update validator function
    String _defaultValidator(String val) {
      if (int.tryParse(val) == null) {
        return AppLocalizations.of(context).errorInteger;
      }
      return null;
    }

    String _umaValidator(String val) {
      if (int.tryParse(_umaBigController.text) == null ||
          int.tryParse(_umaSmallController.text) == null) {
        return AppLocalizations.of(context).errorInteger;
      } else if (int.tryParse(_umaBigController.text) <
          int.tryParse(_umaSmallController.text)) {
        return AppLocalizations.of(context).errorDecreasing;
      }
      return null;
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
                          (val) =>
                              currentSetting.startingPoint = int.tryParse(val),
                          _startingPointController)),
                  RowInput(
                      AppLocalizations.of(context).givenStartingPoint,
                      TextInput(
                          (val) => currentSetting.givenStartingPoint =
                              int.tryParse(val),
                          _givenStartingPointController)),
                  RowInput(
                      AppLocalizations.of(context).riichibouPoint,
                      TextInput(
                          (val) =>
                              currentSetting.riichibouPoint = int.tryParse(val),
                          _riichibouPointController)),
                  RowInput(
                      AppLocalizations.of(context).bonbaPoint,
                      TextInput(
                          (val) =>
                              currentSetting.bonbaPoint = int.tryParse(val),
                          _bonbaPointController)),
                  RowInput(
                      AppLocalizations.of(context).ryukyokuPoint,
                      TextInput(
                          (val) =>
                              currentSetting.ryukyokuPoint = int.tryParse(val),
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
                            (val) => currentSetting.umaBig = int.tryParse(val),
                            _umaBigController,
                            _umaValidator),
                      ),
                      Container(
                        width: 100,
                        padding: EdgeInsets.all(8.0),
                        child: TextInput(
                            (val) =>
                                currentSetting.umaSmall = int.tryParse(val),
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
                          value: firstOya,
                          decoration: _inputDecoration,
                          onChanged: (val) {
                            setState(() {
                              firstOya = val;
                            });
                          },
                          onSaved: (val) {
                            firstOya = val;
                          },
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: SizedBox(
                      width: 350.0,
                      child: CustomCheckBoxTile(currentSetting.kiriage,
                          AppLocalizations.of(context).kiriage, (val) {
                        setState(() {
                          currentSetting.kiriage = val;
                        });
                      }),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 350.0,
                      child: CustomCheckBoxTile(currentSetting.douten,
                          AppLocalizations.of(context).samePoint, (val) {
                        setState(() {
                          currentSetting.douten = val;
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
                  onSelected: (string) {
                    switch (string) {
                      case "currentSetting":
                        setState(() {
                          currentSetting = widget.currentSetting;
                          copySetting(widget.currentSetting);
                        });
                        break;
                      case "RMU A/B RULE":
                        setState(() {
                          currentSetting = _RMUSetting;
                          copySetting(_RMUSetting);
                        });
                        break;
                      case "tenhou":
                        setState(() {
                          currentSetting = _tenhouSetting;
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
                  widget.save(currentSetting, firstOya);
                  Navigator.pop(context);
                }
              }),
            ],
          ),
          color: Colors.blue,
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
  bool kiriage;
  bool douten;

  SettingParameter(
      {this.givenStartingPoint,
      this.startingPoint,
      this.riichibouPoint,
      this.bonbaPoint,
      this.ryukyokuPoint,
      this.umaBig,
      this.umaSmall,
      this.kiriage,
      this.douten});

  SettingParameter clone() {
    return SettingParameter(
      givenStartingPoint: givenStartingPoint,
      startingPoint: startingPoint,
      riichibouPoint: riichibouPoint,
      bonbaPoint: bonbaPoint,
      ryukyokuPoint: ryukyokuPoint,
      umaBig: umaBig,
      umaSmall: umaSmall,
      kiriage: kiriage,
      douten: douten,
    );
  }
}
