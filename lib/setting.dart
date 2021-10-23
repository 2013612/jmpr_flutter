import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'classes/setting.dart' as class_s;
import 'common.dart';
import 'common_widgets/base_bar_button.dart';
import 'common_widgets/custom_check_box_tile.dart';

class Setting extends StatefulWidget {
  final class_s.Setting currentSetting;
  final Function save;

  Setting({
    required this.currentSetting,
    required this.save,
  });

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _settingFormKey = GlobalKey<FormState>();
  late class_s.Setting _editingSetting;
  final class_s.Setting _tenhouSetting = class_s.Setting(
    startingPoint: 30000,
    givenStartingPoint: 25000,
    riichibouPoint: 1000,
    bonbaPoint: 300,
    ryukyokuPoint: 3000,
    umaBig: 20,
    umaSmall: 10,
    isKiriage: false,
    isDouten: false,
    firstOya: Position.bottom,
  );

  // ignore: non_constant_identifier_names
  final class_s.Setting _RMUSetting = class_s.Setting(
    startingPoint: 30000,
    givenStartingPoint: 30000,
    riichibouPoint: 1000,
    bonbaPoint: 300,
    ryukyokuPoint: 3000,
    umaBig: 30,
    umaSmall: 10,
    isKiriage: true,
    isDouten: true,
    firstOya: Position.bottom,
  );
  final InputDecoration _inputDecoration = InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.all(8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
  late TextEditingController _givenStartingPointController,
      _startingPointController,
      _riichibouPointController,
      _bonbaPointController,
      _ryukyokuPointController,
      _umaBigController,
      _umaSmallController;

  static final OutlinedBorder _shapeBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
  );

  @override
  void initState() {
    super.initState();
    _editingSetting = widget.currentSetting;
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
      "currentSetting": AppLocalizations.of(context)!.currentSetting,
      "RMU A/B RULE": AppLocalizations.of(context)!.rmu,
      "tenhou": AppLocalizations.of(context)!.tenhou
    };

    // TODO: update validator function
    String? _defaultValidator(String? input) {
      if (int.tryParse(input!) == null) {
        return AppLocalizations.of(context)!.errorInteger;
      }
      return null;
    }

    String? _umaValidator(_) {
      if (int.tryParse(_umaBigController.text) == null ||
          int.tryParse(_umaSmallController.text) == null) {
        return AppLocalizations.of(context)!.errorInteger;
      } else if (int.tryParse(_umaBigController.text)! <
          int.tryParse(_umaSmallController.text)!) {
        return AppLocalizations.of(context)!.errorDecreasing;
      }
      return null;
    }

    void copySetting(class_s.Setting setting) {
      _givenStartingPointController.text =
          setting.givenStartingPoint.toString();
      _startingPointController.text = setting.startingPoint.toString();
      _riichibouPointController.text = setting.riichibouPoint.toString();
      _bonbaPointController.text = setting.bonbaPoint.toString();
      _ryukyokuPointController.text = setting.ryukyokuPoint.toString();
      _umaBigController.text = setting.umaBig.toString();
      _umaSmallController.text = setting.umaSmall.toString();
    }

    Widget rowInput(String name, Widget widget) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            child: Text(
              "$name:",
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

    Widget textInput(
        void Function(String?) save, TextEditingController controller,
        [String? Function(String?)? validator]) {
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
          title: Text(AppLocalizations.of(context)!.setting),
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
                  rowInput(
                      AppLocalizations.of(context)!.startingPoint,
                      textInput(
                          (String? startingPoint) => _editingSetting
                              .startingPoint = int.tryParse(startingPoint!)!,
                          _startingPointController)),
                  rowInput(
                      AppLocalizations.of(context)!.givenStartingPoint,
                      textInput(
                          (String? givenStartingPoint) =>
                              _editingSetting.givenStartingPoint =
                                  int.tryParse(givenStartingPoint!)!,
                          _givenStartingPointController)),
                  rowInput(
                      AppLocalizations.of(context)!.riichibouPoint,
                      textInput(
                          (String? riichibouPoint) => _editingSetting
                              .riichibouPoint = int.tryParse(riichibouPoint!)!,
                          _riichibouPointController)),
                  rowInput(
                      AppLocalizations.of(context)!.bonbaPoint,
                      textInput(
                          (String? bonbaPoint) => _editingSetting.bonbaPoint =
                              int.tryParse(bonbaPoint!)!,
                          _bonbaPointController)),
                  rowInput(
                      AppLocalizations.of(context)!.ryukyokuPoint,
                      textInput(
                          (String? ryukyokuPoint) => _editingSetting
                              .ryukyokuPoint = int.tryParse(ryukyokuPoint!)!,
                          _ryukyokuPointController)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          "${AppLocalizations.of(context)!.uma}:",
                        ),
                      ),
                      Container(
                        width: 100,
                        padding: EdgeInsets.all(8.0),
                        child: textInput(
                            (String? umaBig) =>
                                _editingSetting.umaBig = int.tryParse(umaBig!)!,
                            _umaBigController,
                            _umaValidator),
                      ),
                      Container(
                        width: 100,
                        padding: EdgeInsets.all(8.0),
                        child: textInput(
                            (String? umaSmall) => _editingSetting.umaSmall =
                                int.tryParse(umaSmall!)!,
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
                            Text("${AppLocalizations.of(context)!.firstOya}:"),
                      ),
                      Container(
                        width: 200,
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<Position>(
                          items: Constant.positionTexts.entries
                              .map((positionText) => DropdownMenuItem<Position>(
                                    value: positionText.key,
                                    child: Text(positionText.value),
                                  ))
                              .toList(),
                          value: _editingSetting.firstOya,
                          decoration: _inputDecoration,
                          onChanged: (Position? firstOya) {
                            setState(() {
                              _editingSetting.firstOya = firstOya!;
                            });
                          },
                          onSaved: (Position? firstOya) {
                            _editingSetting.firstOya = firstOya!;
                          },
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: SizedBox(
                      width: 350.0,
                      child: CustomCheckBoxTile(
                        checkBoxValue: _editingSetting.isKiriage,
                        title: AppLocalizations.of(context)!.kiriage,
                        onChanged: (bool? isKiriage) {
                          setState(() {
                            _editingSetting.isKiriage = isKiriage!;
                          });
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 350.0,
                      child: CustomCheckBoxTile(
                        checkBoxValue: _editingSetting.isDouten,
                        title: AppLocalizations.of(context)!.samePoint,
                        onChanged: (bool? isDouten) {
                          setState(() {
                            _editingSetting.isDouten = isDouten!;
                          });
                        },
                      ),
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
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: Colors.white,
                  elevation: 0.0,
                  shape: _shapeBorder,
                  minimumSize: Size(88, 36),
                ),
                child: PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) {
                    return _usualSettings.entries.map((setting) {
                      return PopupMenuItem<String>(
                        value: setting.key,
                        child: Text(setting.value),
                      );
                    }).toList();
                  },
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
                  child: Text(AppLocalizations.of(context)!.usualSetting),
                ),
              ),
              BaseBarButton(
                name: AppLocalizations.of(context)!.cancel,
                onPress: () => Navigator.pop(context),
              ),
              BaseBarButton(
                name: AppLocalizations.of(context)!.save,
                onPress: () {
                  if (_settingFormKey.currentState!.validate()) {
                    _settingFormKey.currentState!.save();
                    widget.save(_editingSetting);
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
