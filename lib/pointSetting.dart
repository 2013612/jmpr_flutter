import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'common.dart';

class PointSetting extends StatefulWidget {
  PointSettingParameter currentPointSetting;
  Function save;

  PointSetting({
    @required this.currentPointSetting,
    @required this.save,
  });

  @override
  _PointSettingState createState() => _PointSettingState();
}

class _PointSettingState extends State<PointSetting> {
  final _pointSettingFormKey = GlobalKey<FormState>();
  PointSettingParameter currentPointSetting;
  TextEditingController _bottomController,
      _rightController,
      _topController,
      _leftController,
      _bonbaController,
      _riichibouController;

  final InputDecoration _inputDecoration = InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.all(8.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  @override
  void initState() {
    super.initState();
    currentPointSetting = widget.currentPointSetting;
    _bottomController = TextEditingController(
        text: currentPointSetting.players[Position.Bottom].point.toString());
    _rightController = TextEditingController(
        text: currentPointSetting.players[Position.Right].point.toString());
    _topController = TextEditingController(
        text: currentPointSetting.players[Position.Top].point.toString());
    _leftController = TextEditingController(
        text: currentPointSetting.players[Position.Left].point.toString());
    _bonbaController =
        TextEditingController(text: currentPointSetting.bonba.toString());
    _riichibouController =
        TextEditingController(text: currentPointSetting.riichibou.toString());
  }

  @override
  Widget build(BuildContext context) {
    Widget RowInput(String name, Widget widget) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
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
    String _integerValidator(String val) {
      if (int.tryParse(val) == null || int.tryParse(val) % 100 != 0) {
        return "請輸入能被100整除的整數";
      }
      return null;
    }

    String _nonNegativeIntegerValidator(String val) {
      if (int.tryParse(val) == null || int.tryParse(val) < 0) {
        return "請輸入非負整數";
      }
      return null;
    }

    Widget TextInput(
        Function save, TextEditingController controller, Function validator) {
      return TextFormField(
        keyboardType: TextInputType.numberWithOptions(signed: true),
        decoration: _inputDecoration,
        onSaved: save,
        controller: controller,
        validator: validator,
      );
    }

    Widget DropdownInput() {
      return DropdownButtonFormField<String>(
        items: constant.kyokus
            .map((value) =>
                DropdownMenuItem<String>(child: Text(value), value: value))
            .toList(),
        value: constant.kyokus[currentPointSetting.currentKyoku],
        decoration: _inputDecoration,
        onChanged: (val) {
          setState(() {
            currentPointSetting.currentKyoku = constant.kyokus.indexOf(val);
          });
        },
        onSaved: (val) {
          currentPointSetting.currentKyoku = constant.kyokus.indexOf(val);
        },
      );
    }

    void copyPointSetting(PointSettingParameter pointSettingParameter) {
      _bottomController.text =
          pointSettingParameter.players[Position.Bottom].point.toString();
      _rightController.text =
          pointSettingParameter.players[Position.Right].point.toString();
      _topController.text =
          pointSettingParameter.players[Position.Top].point.toString();
      _leftController.text =
          pointSettingParameter.players[Position.Left].point.toString();
      _bonbaController.text = pointSettingParameter.bonba.toString();
      _riichibouController.text = pointSettingParameter.riichibou.toString();
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("場況設定"),
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
                  RowInput(
                      constant.positionTexts[Position.Bottom],
                      TextInput(
                          (val) => currentPointSetting.players[Position.Bottom]
                              .point = int.tryParse(val),
                          _bottomController,
                          _integerValidator)),
                  RowInput(
                      constant.positionTexts[Position.Right],
                      TextInput(
                          (val) => currentPointSetting.players[Position.Right]
                              .point = int.tryParse(val),
                          _rightController,
                          _integerValidator)),
                  RowInput(
                      constant.positionTexts[Position.Top],
                      TextInput(
                          (val) => currentPointSetting
                              .players[Position.Top].point = int.tryParse(val),
                          _topController,
                          _integerValidator)),
                  RowInput(
                      constant.positionTexts[Position.Left],
                      TextInput(
                          (val) => currentPointSetting
                              .players[Position.Left].point = int.tryParse(val),
                          _leftController,
                          _integerValidator)),
                  RowInput("局", DropdownInput()),
                  RowInput(
                      "本場",
                      TextInput(
                          (val) =>
                              currentPointSetting.bonba = int.tryParse(val),
                          _bonbaController,
                          _nonNegativeIntegerValidator)),
                  RowInput(
                      "供托",
                      TextInput(
                          (val) =>
                              currentPointSetting.riichibou = int.tryParse(val),
                          _riichibouController,
                          _nonNegativeIntegerValidator)),
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
                  "現在的場況", () => copyPointSetting(widget.currentPointSetting)),
              BaseBarButton("取消", () => Navigator.pop(context)),
              BaseBarButton("儲存", () {
                if (_pointSettingFormKey.currentState.validate()) {
                  _pointSettingFormKey.currentState.save();
                  widget.save(currentPointSetting);
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

class Player {
  Position position;
  int point;

  Player({this.position, this.point});
}

class PointSettingParameter {
  Map<Position, Player> players;
  int currentKyoku;
  int bonba;
  int riichibou;

  PointSettingParameter(
      {this.players, this.currentKyoku, this.bonba, this.riichibou});
}
