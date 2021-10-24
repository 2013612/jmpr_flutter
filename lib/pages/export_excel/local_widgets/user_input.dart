import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common_widgets/base_bar_button.dart';
import '../../../common_widgets/row_input.dart';
import '../../../common_widgets/text_input.dart';
import '../../../utility/constant.dart';
import '../../../utility/validators.dart';
import 'position_point_setting.dart';

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
  String? folder, fileName, sheetName;

  @override
  void initState() {
    super.initState();
    for (Position position in Position.values) {
      playerNames[position] = Constant.positionTexts[position]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final InputDecoration _inputDecoration = InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.all(8.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorStyle: TextStyle(
        height: 0.0,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.setting),
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
                    .map(
                      (position) => PositionPointSetting(
                        position: position,
                        playerNames: playerNames,
                      ),
                    )
                    .toList(),
                RowInput(
                  name: i18n.folder,
                  widget: TextFormField(
                    readOnly: true,
                    controller: _folderController,
                    onTap: () async {
                      final extDirPath = Directory(
                          await ExtStorage.getExternalStorageDirectory() ?? "");
                      final path = await (FilesystemPicker.open(
                        title: "Save to folder",
                        context: context,
                        rootDirectory: Directory(extDirPath.path),
                        fsType: FilesystemType.folder,
                        pickText: "Save file to this folder",
                        requestPermission: () async =>
                            await Permission.storage.request().isGranted,
                      ));
                      _folderController.text = path ?? "";
                    },
                    onSaved: (String? path) => folder = path,
                    validator: Validators.empty,
                    decoration: _inputDecoration,
                  ),
                ),
                RowInput(
                  name: i18n.file,
                  widget: Row(
                    children: [
                      Flexible(
                        child: TextInput(
                          initialValue: "${i18n.spreadsheet}1",
                          onSaved: (String? name) => fileName = name,
                          validator: Validators.empty,
                        ),
                      ),
                      Text(".xlsx"),
                    ],
                  ),
                ),
                RowInput(
                  name: i18n.sheet,
                  widget: TextInput(
                    initialValue: "${i18n.sheet}1",
                    onSaved: (String? name) => sheetName = name,
                    validator: Validators.empty,
                  ),
                ),
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
            BaseBarButton(
              name: i18n.cancel,
              onPress: () => Navigator.pop(context),
            ),
            BaseBarButton(
              name: i18n.save,
              onPress: () {
                if (_userInputFormKey.currentState!.validate()) {
                  _userInputFormKey.currentState!.save();
                  widget
                      .save(folder, fileName, sheetName, playerNames)
                      .then((bool success) {
                    if (success) {
                      Navigator.pop(context);
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
