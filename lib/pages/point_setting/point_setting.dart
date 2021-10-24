import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../classes/point_setting.dart' as ps;
import '../../common_widgets/base_bar_button.dart';
import '../../common_widgets/row_input.dart';
import '../../common_widgets/text_input.dart';
import '../../utility/constant.dart';
import '../../utility/validators.dart';
import 'local_widgets/position_point_setting.dart';

class PointSetting extends StatefulWidget {
  final ps.PointSetting currentPointSetting;
  final Function save;

  PointSetting({
    required this.currentPointSetting,
    required this.save,
  });

  @override
  _PointSettingState createState() => _PointSettingState();
}

class _PointSettingState extends State<PointSetting> {
  final _pointSettingFormKey = GlobalKey<FormState>();
  late ps.PointSetting _currentPointSetting;
  late Map<Position, TextEditingController> _positionControllers;
  late TextEditingController _bonbaController, _riichibouController;

  @override
  void initState() {
    super.initState();
    _currentPointSetting = widget.currentPointSetting;
    _positionControllers = {};
    for (Position position in Position.values) {
      _positionControllers[position] = TextEditingController(
          text: _currentPointSetting.players[position]!.point.toString());
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

    void copyPointSetting(ps.PointSetting pointSettingParameter) {
      for (Position position in Position.values) {
        _positionControllers[position]!.text =
            pointSettingParameter.players[position]!.point.toString();
      }
      _bonbaController.text = pointSettingParameter.bonba.toString();
      _riichibouController.text = pointSettingParameter.riichibou.toString();
    }

    final Widget dropdownInput = DropdownButtonFormField<String>(
      items: Constant.kyokus
          .map((String kyoku) =>
              DropdownMenuItem<String>(value: kyoku, child: Text(kyoku)))
          .toList(),
      value: Constant.kyokus[_currentPointSetting.currentKyoku],
      decoration: _inputDecoration,
      onChanged: (String? kyoku) {
        setState(() {
          _currentPointSetting.currentKyoku = Constant.kyokus.indexOf(kyoku!);
        });
      },
      onSaved: (String? kyoku) {
        _currentPointSetting.currentKyoku = Constant.kyokus.indexOf(kyoku!);
      },
    );

    void Function(String?) posPointSettingOnSave(Position position) {
      return (String? point) =>
          _currentPointSetting.players[position]!.point = int.tryParse(point!)!;
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.pointSetting),
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
                  ...Position.values
                      .map(
                        (position) => PositionPointSetting(
                          controller: _positionControllers[position]!,
                          onSaved: posPointSettingOnSave(position),
                          position: position,
                        ),
                      )
                      .toList(),
                  RowInput(
                    name: AppLocalizations.of(context)!.kyoku,
                    widget: dropdownInput,
                  ),
                  RowInput(
                    name: AppLocalizations.of(context)!.bonba,
                    widget: TextInput(
                      onSaved: (String? bonba) =>
                          _currentPointSetting.bonba = int.tryParse(bonba!)!,
                      controller: _bonbaController,
                      validator: Validators.nonNegativeInteger,
                    ),
                  ),
                  RowInput(
                    name: AppLocalizations.of(context)!.kyoutaku,
                    widget: TextInput(
                      onSaved: (String? kyoutaku) => _currentPointSetting
                          .riichibou = int.tryParse(kyoutaku!)!,
                      controller: _riichibouController,
                      validator: Validators.nonNegativeInteger,
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
              BaseBarButton(
                name: AppLocalizations.of(context)!.currentPointSetting,
                onPress: () => copyPointSetting(widget.currentPointSetting),
              ),
              BaseBarButton(
                name: AppLocalizations.of(context)!.cancel,
                onPress: () => Navigator.pop(context),
              ),
              BaseBarButton(
                name: AppLocalizations.of(context)!.save,
                onPress: () {
                  if (_pointSettingFormKey.currentState!.validate()) {
                    _pointSettingFormKey.currentState!.save();
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