import 'dart:io';
import 'dart:math';

import 'package:ext_storage/ext_storage.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'common.dart';
import 'history.dart';

class ChooseHistory extends StatefulWidget {
  final List<History> histories;
  final Function next;

  ChooseHistory({
    @required this.histories,
    @required this.next,
  });

  @override
  _ChooseHistoryState createState() => _ChooseHistoryState();
}

class _ChooseHistoryState extends State<ChooseHistory> {
  List<int> chosen;
  List<History> reversedHistories;

  @override
  void initState() {
    super.initState();
    chosen = [];
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
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            baseBarButton(AppLocalizations.of(context).cancel,
                () => Navigator.pop(context)),
            baseBarButton(AppLocalizations.of(context).next, () {
              if (chosen.length < 2) {
                Fluttertoast.showToast(
                    msg: AppLocalizations.of(context).errorExactTwoRecords,
                    backgroundColor: Colors.red);
                return;
              } else if (!reversedHistories[chosen[0]]
                  .setting
                  .equal(reversedHistories[chosen[1]].setting)) {
                Fluttertoast.showToast(
                    msg: AppLocalizations.of(context).errorSettingsAreDifferent,
                    backgroundColor: Colors.red);
                return;
              } else {
                chosen[0] = reversedHistories.length - 1 - chosen[0];
                chosen[1] = reversedHistories.length - 1 - chosen[1];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInput(
                      (String folder, String fileName, String sheetName,
                          Map<Position, String> playerNames) {
                        widget.next(
                            min(chosen[0], chosen[1]),
                            max(chosen[0], chosen[1]),
                            folder,
                            fileName,
                            sheetName,
                            playerNames);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class UserInput extends StatefulWidget {
  final Function save;

  UserInput(this.save);

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final _userInputFormKey = GlobalKey<FormState>();
  final TextEditingController _folderController = TextEditingController();
  final Map<Position, String> playerNames = {};
  String folder, fileName, sheetName;

  @override
  void initState() {
    super.initState();
    for (Position position in Position.values) {
      playerNames[position] = Constant.positionTexts[position];
    }
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

    Widget rowInput(String name, Widget widget, [IconData icon]) {
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

    Widget textInput(String initialValue, void Function(String) save,
        [String Function(String) validator]) {
      validator ??= (val) => null;
      return TextFormField(
        initialValue: initialValue,
        decoration: _inputDecoration,
        onSaved: save,
        validator: validator,
      );
    }

    Widget positionPointSetting(Position position) {
      return rowInput(
        Constant.positionTexts[position],
        textInput(playerNames[position],
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
                ...Position.values.map(positionPointSetting).toList(),
                rowInput(
                    AppLocalizations.of(context).folder,
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
                rowInput(
                  AppLocalizations.of(context).file,
                  Row(
                    children: [
                      Flexible(
                        child: textInput(
                            "${AppLocalizations.of(context).spreadsheet}1",
                            (String name) => fileName = name,
                            (String name) =>
                                name != null && name != "" ? null : ""),
                      ),
                      Text(".xlsx"),
                    ],
                  ),
                ),
                rowInput(
                    AppLocalizations.of(context).sheet,
                    textInput(
                        "${AppLocalizations.of(context).sheet}1",
                        (String name) => sheetName = name,
                        (String name) =>
                            name != null && name != "" ? null : "")),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            baseBarButton(AppLocalizations.of(context).cancel,
                () => Navigator.pop(context)),
            baseBarButton(AppLocalizations.of(context).save, () {
              if (_userInputFormKey.currentState.validate()) {
                _userInputFormKey.currentState.save();
                widget.save(folder, fileName, sheetName, playerNames);
                Navigator.pop(context);
              }
            }),
          ],
        ),
      ),
    );
  }
}
