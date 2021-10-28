import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../classes/setting.dart' as class_s;
import '../../common_widgets/base_bar_button.dart';
import '../../common_widgets/custom_check_box_tile.dart';
import '../../common_widgets/row_input.dart';
import '../../common_widgets/text_input.dart';
import '../../utility/constant.dart';

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
    final i18n = AppLocalizations.of(context)!;
    final Map<String, String> _usualSettings = {
      "currentSetting": i18n.currentSetting,
      "RMU A/B RULE": i18n.rmu,
      "tenhou": i18n.tenhou
    };

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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(i18n.setting),
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
                    name: i18n.startingPoint,
                    widget: TextInput(
                      onSaved: (String? startingPoint) => _editingSetting
                          .startingPoint = int.tryParse(startingPoint!)!,
                      controller: _startingPointController,
                    ),
                  ),
                  RowInput(
                    name: i18n.givenStartingPoint,
                    widget: TextInput(
                      onSaved: (String? givenStartingPoint) =>
                          _editingSetting.givenStartingPoint =
                              int.tryParse(givenStartingPoint!)!,
                      controller: _givenStartingPointController,
                    ),
                  ),
                  RowInput(
                    name: i18n.riichibouPoint,
                    widget: TextInput(
                      onSaved: (String? riichibouPoint) => _editingSetting
                          .riichibouPoint = int.tryParse(riichibouPoint!)!,
                      controller: _riichibouPointController,
                    ),
                  ),
                  RowInput(
                    name: i18n.bonbaPoint,
                    widget: TextInput(
                      onSaved: (String? bonbaPoint) => _editingSetting
                          .bonbaPoint = int.tryParse(bonbaPoint!)!,
                      controller: _bonbaPointController,
                    ),
                  ),
                  RowInput(
                    name: i18n.ryukyokuPoint,
                    widget: TextInput(
                      onSaved: (String? ryukyokuPoint) => _editingSetting
                          .ryukyokuPoint = int.tryParse(ryukyokuPoint!)!,
                      controller: _ryukyokuPointController,
                    ),
                  ),
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
                        child: TextInput(
                          onSaved: (String? umaBig) =>
                              _editingSetting.umaBig = int.tryParse(umaBig!)!,
                          controller: _umaBigController,
                          validator: _umaValidator,
                        ),
                      ),
                      Container(
                        width: 100,
                        padding: EdgeInsets.all(8.0),
                        child: TextInput(
                          onSaved: (String? umaSmall) => _editingSetting
                              .umaSmall = int.tryParse(umaSmall!)!,
                          controller: _umaSmallController,
                          validator: _umaValidator,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: Text("${i18n.firstOya}:"),
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
                        title: i18n.kiriage,
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
                        title: i18n.samePoint,
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
                  child: Text(i18n.usualSetting),
                ),
              ),
              BaseBarButton(
                name: i18n.cancel,
                onPress: () => Navigator.pop(context),
              ),
              BaseBarButton(
                name: i18n.save,
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
