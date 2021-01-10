import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PointSetting extends StatefulWidget {

  @override
  _PointSettingState createState() => _PointSettingState();
}

class _PointSettingState extends State<PointSetting> {
  final InputDecoration _inputDecoration = InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.all(8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  static final ShapeBorder _shapeBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
  );

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

    Widget TextInput(String initialValue, Function save) {
      return TextFormField(
        keyboardType: TextInputType.numberWithOptions(signed: true),
        initialValue: initialValue,
        decoration: _inputDecoration,
        // TODO: fill onSaved()
        onSaved: save,
      );
    }

    Widget DropdownInput(String initialValue, Function save, List<DropdownMenuItem> list) {
      return DropdownButtonFormField<String>(
        items: list,//_activityTypes.map((value) => DropdownMenuItem(child: Text(value), value: value)).toList(),
        value: initialValue,
        decoration: _inputDecoration,
        onChanged: (value) {
          setState(() {
            //_eventState.activityType = value.toString();
          });
        },
        // TODO: fill onSaved()
        onSaved: save,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RowInput("下", TextInput("", null)),
                  RowInput("右", TextInput("", null)),
                  RowInput("上", TextInput("", null)),
                  RowInput("左", TextInput("", null)),
                  RowInput("局", DropdownInput("", null, null)),
                  RowInput("本場", TextInput("", null)),
                  RowInput("供托", TextInput("", null)),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BaseBarButton("現在的場況", null),
              BaseBarButton("取消", () => Navigator.pop(context)),
              BaseBarButton("儲存", null),
            ],
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}