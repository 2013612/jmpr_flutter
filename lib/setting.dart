import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  SettingParameter currentSetting;
  Function save;
  Setting({
    @required this.currentSetting,
    @required this.save,
  });

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _settingFormKey = GlobalKey<FormState>();
  SettingParameter currentSetting;
  final SettingParameter _tenhouSetting = SettingParameter(startingPoint: 30000, givenStartingPoint: 25000, riichibouPoint: 1000, bonbaPoint: 300, umaBig: 20, umaSmall: 10, kiriage: false, douten: false);
  final SettingParameter _RMUSetting = SettingParameter(startingPoint: 30000, givenStartingPoint: 30000, riichibouPoint: 1000, bonbaPoint: 300, umaBig: 30, umaSmall: 10, kiriage: true, douten: true);
  final InputDecoration _inputDecoration = InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.all(8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
  TextEditingController _givenStartingPointController, _startingPointController, _riichibouPointController, _bonbaPointController, _umaBigController, _umaSmallController;

  static final ShapeBorder _shapeBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
  );

  final List<String> _usualSettings = ["現在的設定", "RMU A/B RULE", "天鳳"];

  @override
  void initState() {
    super.initState();
    currentSetting = widget.currentSetting ?? _tenhouSetting;
    _givenStartingPointController = TextEditingController(text: currentSetting.givenStartingPoint.toString());
    _startingPointController = TextEditingController(text: currentSetting.startingPoint.toString());
    _riichibouPointController = TextEditingController(text: currentSetting.riichibouPoint.toString());
    _bonbaPointController = TextEditingController(text: currentSetting.bonbaPoint.toString());
    _umaBigController = TextEditingController(text: currentSetting.umaBig.toString());
    _umaSmallController = TextEditingController(text: currentSetting.umaSmall.toString());
  }

  @override
  Widget build(BuildContext context) {
    Widget RowInput(String name, Widget widget) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
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
        return "請輸入整數";
      }
      return null;
    }

    String _umaValidator(String val) {
      if (int.tryParse(_umaBigController.text) == null || int.tryParse(_umaSmallController.text) == null) {
        return "請輸入整數";
      } else if (int.tryParse(_umaBigController.text) < int.tryParse(_umaSmallController.text)) {
        return "請由大至小輸入馬點";
      }
      return null;
    }

    Widget TextInput(Function save, TextEditingController controller, [Function validator]) {
      validator ??= _defaultValidator;
      return TextFormField(
        keyboardType: TextInputType.numberWithOptions(signed: true),
        decoration: _inputDecoration,
        onSaved: save,
        controller: controller,
        validator: validator,
      );
    }

    Widget BaseBarButton(String name, Function pressed) {
      return RaisedButton(
        child: Text(
          name,
        ),
        onPressed: pressed,
        textColor: Colors.black,
        color: Colors.white,
        elevation: 0.0,
        shape: _shapeBorder,
      );
    }

    void copySetting(SettingParameter setting) {
      _givenStartingPointController.text = setting.givenStartingPoint.toString();
      _startingPointController.text = setting.startingPoint.toString();
      _riichibouPointController.text = setting.riichibouPoint.toString();
      _bonbaPointController.text = setting.bonbaPoint.toString();
      _umaBigController.text = setting.umaBig.toString();
      _umaSmallController.text = setting.umaSmall.toString();
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("設定"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _settingFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RowInput("起始點", TextInput((val) => currentSetting.startingPoint = int.tryParse(val), _startingPointController)),
                  RowInput("原點", TextInput((val) => currentSetting.givenStartingPoint = int.tryParse(val), _givenStartingPointController)),
                  RowInput("立直棒點", TextInput((val) => currentSetting.riichibouPoint = int.tryParse(val), _riichibouPointController)),
                  RowInput("本場棒點", TextInput((val) => currentSetting.bonbaPoint = int.tryParse(val), _bonbaPointController)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        child: Text(
                            "馬點:",
                        ),
                      ),
                      Container(
                        width: 100,
                        padding: EdgeInsets.all(8.0),
                        child: TextInput((val) => currentSetting.umaBig = int.tryParse(val), _umaBigController, _umaValidator),
                      ),
                      Container(
                        width: 100,
                        padding: EdgeInsets.all(8.0),
                        child: TextInput((val) => currentSetting.umaSmall = int.tryParse(val), _umaSmallController, _umaValidator),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: CheckboxListTile(
                          value: currentSetting.kiriage,
                          title: Text("切上滿貫"),
                          onChanged: (val) {
                            setState(() {
                              currentSetting.kiriage = val;
                            });
                          },
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Flexible(
                        child: CheckboxListTile(
                          value: currentSetting.douten,
                          title: Text("同點同順位"),
                          onChanged: (val) {
                            setState(() {
                              currentSetting.douten = val;
                            });
                          },
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
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
                    return _usualSettings.map(
                            (setting) {
                          return PopupMenuItem<String>(
                            value: setting,
                            child: Text(setting),
                          );
                        }
                    ).toList();
                  },
                  child: Text("常用設定"),
                  onSelected: (string) {
                    switch (string) {
                      case "現在的設定":
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
                      case "天鳳":
                        setState(() {
                          currentSetting = _tenhouSetting;
                          copySetting(_tenhouSetting);
                        });
                        break;
                    }
                  },
                ),
              ),
              BaseBarButton("取消", () => Navigator.pop(context)),
              BaseBarButton("儲存", () {
                if (_settingFormKey.currentState.validate()) {
                  _settingFormKey.currentState.save();
                  widget.save(currentSetting);
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
  int umaSmall;
  int umaBig;
  bool kiriage;
  bool douten;

  SettingParameter({this.givenStartingPoint, this.startingPoint, this.riichibouPoint, this.bonbaPoint, this.umaBig, this.umaSmall, this.kiriage, this.douten});
}