import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jmpr_flutter/providers/indexes_provider.dart';
import 'package:tuple/tuple.dart';

import '../../common_widgets/base_bar_button.dart';
import '../../common_widgets/custom_check_box_tile.dart';
import '../../common_widgets/row_input.dart';
import '../../common_widgets/text_input.dart';
import '../../models/game.dart';
import '../../models/point_setting.dart';
import '../../models/setting.dart' as class_s;
import '../../providers/games.dart';
import '../../utility/constant.dart';
import '../../utility/enum/position.dart';

class Setting extends ConsumerStatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends ConsumerState<Setting> {
  final _settingFormKey = GlobalKey<FormState>();
  late class_s.Setting _editingSetting;
  final class_s.Setting _tenhouSetting = Constant.tenhouSetting;
  // ignore: non_constant_identifier_names
  final class_s.Setting _bRuleSetting = Constant.bRuleSetting;
  late TextEditingController _givenStartingPointController,
      _startingPointController,
      _riichibouPointController,
      _bonbaPointController,
      _ryukyokuPointController,
      _umaBigController,
      _umaSmallController;

  @override
  void initState() {
    super.initState();
    final games = ref.read(gamesProvider);
    final index = ref.read(indexProvider);
    _editingSetting = games[index.item1].setting.copyWith();

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

    final InputDecoration _inputDecoration = InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.all(8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    final Map<String, String> _usualSettings = {
      "currentSetting": i18n.currentSetting,
      "bRule": i18n.bRule,
      "tenhou": i18n.tenhou
    };

    String? _umaValidator(_) {
      final umaBig = int.tryParse(_umaBigController.text);
      final umaSmall = int.tryParse(_umaSmallController.text);
      if (umaBig == null || umaSmall == null) {
        return i18n.errorInteger;
      } else if (umaBig < umaSmall) {
        return i18n.errorDecreasing;
      }
      return null;
    }

    void copySetting() {
      _givenStartingPointController.text =
          _editingSetting.givenStartingPoint.toString();
      _startingPointController.text = _editingSetting.startingPoint.toString();
      _riichibouPointController.text =
          _editingSetting.riichibouPoint.toString();
      _bonbaPointController.text = _editingSetting.bonbaPoint.toString();
      _ryukyokuPointController.text = _editingSetting.ryukyokuPoint.toString();
      _umaBigController.text = _editingSetting.umaBig.toString();
      _umaSmallController.text = _editingSetting.umaSmall.toString();
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
                      onSaved: (String? startingPoint) =>
                          _editingSetting.copyWith(
                              startingPoint:
                                  int.tryParse(startingPoint ?? "") ?? 0),
                      controller: _startingPointController,
                    ),
                  ),
                  RowInput(
                    name: i18n.givenStartingPoint,
                    widget: TextInput(
                      onSaved: (String? givenStartingPoint) =>
                          _editingSetting.copyWith(
                              givenStartingPoint:
                                  int.tryParse(givenStartingPoint ?? "") ?? 0),
                      controller: _givenStartingPointController,
                    ),
                  ),
                  RowInput(
                    name: i18n.riichibouPoint,
                    widget: TextInput(
                      onSaved: (String? riichibouPoint) =>
                          _editingSetting.copyWith(
                              riichibouPoint:
                                  int.tryParse(riichibouPoint ?? "") ?? 0),
                      controller: _riichibouPointController,
                    ),
                  ),
                  RowInput(
                    name: i18n.bonbaPoint,
                    widget: TextInput(
                      onSaved: (String? bonbaPoint) => _editingSetting.copyWith(
                          bonbaPoint: int.tryParse(bonbaPoint ?? "") ?? 0),
                      controller: _bonbaPointController,
                    ),
                  ),
                  RowInput(
                    name: i18n.ryukyokuPoint,
                    widget: TextInput(
                      onSaved: (String? ryukyokuPoint) =>
                          _editingSetting.copyWith(
                              ryukyokuPoint:
                                  int.tryParse(ryukyokuPoint ?? "") ?? 0),
                      controller: _ryukyokuPointController,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          "${i18n.uma}:",
                        ),
                      ),
                      Container(
                        width: 100,
                        padding: EdgeInsets.all(8.0),
                        child: TextInput(
                          onSaved: (String? umaBig) => _editingSetting.copyWith(
                              umaBig: int.tryParse(umaBig ?? "") ?? 0),
                          controller: _umaBigController,
                          validator: _umaValidator,
                        ),
                      ),
                      Container(
                        width: 100,
                        padding: EdgeInsets.all(8.0),
                        child: TextInput(
                          onSaved: (String? umaSmall) =>
                              _editingSetting.copyWith(
                                  umaSmall: int.tryParse(umaSmall ?? "") ?? 0),
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
                              _editingSetting.copyWith(
                                  firstOya: firstOya ?? Position.bottom);
                            });
                          },
                          onSaved: (Position? firstOya) {
                            _editingSetting.copyWith(
                                firstOya: firstOya ?? Position.bottom);
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
                            _editingSetting.copyWith(
                                isKiriage: isKiriage ?? false);
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
                            _editingSetting.copyWith(
                                isDouten: isDouten ?? false);
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
              // This ElevatedButton is used just for the size and shape, does not used as a button
              ElevatedButton(
                onPressed: () {},
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
                          final games = ref.watch(gamesProvider);
                          final index = ref.watch(indexProvider);
                          _editingSetting =
                              games[index.item1].setting.copyWith();
                        });
                        break;
                      case "bRule":
                        setState(() {
                          _editingSetting = _bRuleSetting;
                        });
                        break;
                      case "tenhou":
                        setState(() {
                          _editingSetting = _tenhouSetting;
                        });
                        break;
                    }
                    copySetting();
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
                    final index = ref.watch(indexProvider);

                    ref.watch(gamesProvider).add(
                          Game(
                            gamePlayers: [],
                            createdAt: DateTime.now(),
                            setting: _editingSetting,
                            transactions: [],
                            pointSettings: [
                              PointSetting.fromSetting(_editingSetting)
                            ],
                          ),
                        );
                    ref.watch(indexProvider.state).state =
                        Tuple2(index.item1 + 1, 0);

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
