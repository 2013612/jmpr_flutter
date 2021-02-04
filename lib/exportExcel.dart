import 'dart:io';
import 'dart:math';

import 'package:ext_storage/ext_storage.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jmpr_flutter/history.dart';
import 'package:permission_handler/permission_handler.dart';
import 'common.dart';

class chooseHistory extends StatefulWidget {
  final List<History> histories;
  Function save;

  chooseHistory({
    @required this.histories,
    @required this.save,
  });

  @override
  _chooseHistoryState createState() => _chooseHistoryState();
}

class _chooseHistoryState extends State<chooseHistory> {
  List<int> chosen = [];
  List<History> reversedHistories;

  @override
  void initState() {
    super.initState();
    reversedHistories = widget.histories.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final ShapeBorder _shapeBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).history),
      ),
      body: ListView.builder(
        itemCount: reversedHistories.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(
                "${Constant.kyokus[reversedHistories[index].pointSetting.currentKyoku]} - ${reversedHistories[index].pointSetting.bonba}"),
            title: FittedBox(
              child: Text(
                reversedHistories[index].pointSetting.players.entries.fold(
                    "",
                    (previousValue, player) =>
                        "$previousValue ${Constant.positionTexts[player.key]}: ${player.value.point}"),
              ),
            ),
            shape: _shapeBorder,
            dense: true,
            selected: chosen.contains(index),
            onTap: () {
              if (chosen.contains(index)) {
                setState(() {
                  chosen.remove(index);
                });
              } else {
                if (chosen.length == 2) {
                  return;
                } else {
                  setState(() {
                    chosen.add(index);
                  });
                }
              }
              print(chosen);
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BaseBarButton(AppLocalizations.of(context).cancel,
                () => Navigator.pop(context)),
            BaseBarButton(AppLocalizations.of(context).next, () {
              if (chosen.length < 2) {
                return;
              } else {
                chosen[0] = reversedHistories.length - 1 - chosen[0];
                chosen[1] = reversedHistories.length - 1 - chosen[1];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => userInput(
                            (String folder, String fileName, String sheetName,
                                Map<Position, String> playerNames) {
                              widget.save(
                                  min(chosen[0], chosen[1]),
                                  max(chosen[0], chosen[1]),
                                  folder,
                                  fileName,
                                  sheetName,
                                  playerNames);
                              Navigator.pop(context);
                            },
                          )),
                );
              }
            }),
          ],
        ),
        color: Colors.blue,
      ),
    );
  }
}

class userInput extends StatefulWidget {
  Function save;

  userInput(this.save);

  @override
  _userInputState createState() => _userInputState();
}

class _userInputState extends State<userInput> {
  final _userInputFormKey = GlobalKey<FormState>();
  final TextEditingController _folderController = TextEditingController();
  final Map<Position, String> playerNames = Map();
  String folder, fileName, sheetName;

  @override
  void initState() {
    super.initState();
    Position.values.forEach(
        (element) => playerNames[element] = Constant.positionTexts[element]);
  }

  @override
  Widget build(BuildContext context) {
    final InputDecoration _inputDecoration = InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(8.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorStyle: TextStyle(
          height: 0.0,
        ));

    Widget RowInput(String name, Widget widget, [IconData icon]) {
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

    Widget TextInput(String initialValue, Function save, [Function validator]) {
      validator ??= (val) => null;
      return TextFormField(
        initialValue: initialValue,
        decoration: _inputDecoration,
        onSaved: save,
        validator: validator,
      );
    }

    Widget PositionPointSetting(Position position) {
      return RowInput(
        Constant.positionTexts[position],
        TextInput(playerNames[position],
            (String name) => playerNames[position] = name),
        Constant.arrows[position],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).setting),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _userInputFormKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                ...Position.values
                    .map((position) => PositionPointSetting(position))
                    .toList(),
                RowInput(
                    "Folder",
                    TextFormField(
                      readOnly: true,
                      controller: _folderController,
                      onTap: () async {
                        final extDirPath = Directory(
                            await ExtStorage.getExternalStorageDirectory());
                        final String path = await FilesystemPicker.open(
                          title: "Save to folder",
                          context: context,
                          rootDirectory: Directory(extDirPath.path),
                          fsType: FilesystemType.folder,
                          pickText: "Save file to this folder",
                          requestPermission: () async =>
                              await Permission.storage.request().isGranted,
                        );
                        _folderController.text = path;
                      },
                      onSaved: (String path) => folder = path,
                      validator: (String path) =>
                          path != null && path != "" ? null : "",
                      decoration: _inputDecoration,
                    )),
                Row(
                  children: [
                    RowInput(
                        "File Name",
                        TextInput(
                            "",
                            (String name) => fileName = name,
                            (String name) =>
                                name != null && name != "" ? null : "")),
                    Text(".xlsx"),
                  ],
                ),
                RowInput(
                    "Sheet Name",
                    TextInput(
                        "Sheet1",
                        (String name) => sheetName = name,
                        (String name) =>
                            name != null && name != "" ? null : "")),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BaseBarButton(AppLocalizations.of(context).cancel,
                () => Navigator.pop(context)),
            BaseBarButton(AppLocalizations.of(context).save, () {
              if (_userInputFormKey.currentState.validate()) {
                _userInputFormKey.currentState.save();
                widget.save(folder, fileName, sheetName, playerNames);
                Navigator.pop(context);
              }
            }),
          ],
        ),
        color: Colors.blue,
      ),
    );
  }
}
