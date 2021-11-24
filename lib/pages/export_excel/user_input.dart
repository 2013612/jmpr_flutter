import 'dart:io';

import 'package:excel/excel.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../classes/setting.dart';
import '../../common_widgets/base_bar_button.dart';
import '../../common_widgets/row_input.dart';
import '../../common_widgets/text_input.dart';
import '../../providers/histories.dart';
import '../../utility/constant.dart';
import '../../utility/validators.dart';
import 'local_widgets/player_name_input.dart';

class UserInput extends ConsumerStatefulWidget {
  final int start;
  final int end;

  UserInput(this.start, this.end);

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends ConsumerState<UserInput> {
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

    Future<Excel?> createExcelFile(
      String folder,
      String fileName,
      String sheetName,
    ) async {
      Excel? excel;
      try {
        final bytes = File(join(folder, "$fileName.xlsx")).readAsBytesSync();
        excel = Excel.decodeBytes(bytes);
        if (excel.tables.keys.contains(sheetName)) {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(AppLocalizations.of(context)!
                  .warningExistingSheetName(sheetName, fileName)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                TextButton(
                  onPressed: () {
                    OpenFile.open(join(folder, "$fileName.xlsx"));
                    Navigator.pop(context);
                  },
                  child:
                      Text(AppLocalizations.of(context)!.openExcel(fileName)),
                ),
              ],
            ),
          );
          return null;
        }
      } on Exception catch (exception) {
        print(exception);
      }
      if (excel == null) {
        excel = Excel.createExcel();
        excel.rename("Sheet1", sheetName);
      }
      return excel;
    }

    Future<bool> generateExcel(
      int startIndex,
      int endIndex,
      String folder,
      String fileName,
      String sheetName,
      Map<Position, String> playerNames,
    ) async {
      Excel? excel = await createExcelFile(folder, fileName, sheetName);
      if (excel == null) {
        return false;
      }
      final int topRow = 2;
      final histories = ref.watch(historiesProvider);
      final Setting _setting = histories[endIndex].setting;

      CellIndex cell(int col, int row) {
        return CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row);
      }

      Position position(int index) {
        return Position.values[(_setting.firstOya.index + index) % 4];
      }

      Map<Position, double> marks = histories[endIndex].calResult();

      excel.updateCell(
          sheetName, cell(0, 1), AppLocalizations.of(context)!.kyoku);
      excel.updateCell(
          sheetName, cell(1, 1), AppLocalizations.of(context)!.oya);
      List.generate(4, (index) {
        excel.merge(sheetName, cell(2 + 3 * index, 0), cell(4 + 3 * index, 0),
            customValue: playerNames[position(index)]);
        excel.updateCell(sheetName, cell(2 + 3 * index, 1),
            AppLocalizations.of(context)!.riichi);
        excel.updateCell(sheetName, cell(3 + 3 * index, 1),
            AppLocalizations.of(context)!.pointVariation);
        excel.updateCell(sheetName, cell(4 + 3 * index, 1),
            AppLocalizations.of(context)!.currentPoint);
        excel.updateCell(
            sheetName,
            cell(4 + 3 * index, endIndex - startIndex + topRow),
            histories[endIndex].pointSetting.players[position(index)]!.point);
        excel.updateCell(
            sheetName,
            cell(4 + 3 * index, endIndex - startIndex + 1 + topRow),
            marks[position(index)]);
      });
      excel.updateCell(
          sheetName, cell(14, 1), AppLocalizations.of(context)!.kyoutaku);

      void updateExcelKyoku(int row, int pos) {
        excel.updateCell(
            sheetName,
            cell(2 + pos * 3, row + topRow - startIndex),
            histories[row + 1]
                .pointSetting
                .players[position(pos)]!
                .riichi
                .toString()
                .toUpperCase());
        excel.updateCell(
            sheetName,
            cell(3 + pos * 3, row + topRow - startIndex),
            histories[row + 1].pointSetting.players[position(pos)]!.point -
                histories[row].pointSetting.players[position(pos)]!.point);
        excel.updateCell(
            sheetName,
            cell(4 + pos * 3, row + topRow - startIndex),
            histories[row].pointSetting.players[position(pos)]!.point);
      }

      for (int i = startIndex; i < endIndex; i++) {
        excel.updateCell(sheetName, cell(0, i - startIndex + topRow),
            "${Constant.kyokus[histories[i].pointSetting.currentKyoku]} ${histories[i].pointSetting.bonba}${AppLocalizations.of(context)!.bonba}");
        excel.updateCell(
            sheetName,
            cell(1, i - startIndex + topRow),
            playerNames[Position.values[(_setting.firstOya.index +
                    histories[i].pointSetting.currentKyoku) %
                4]]);
        List.generate(4, (index) => updateExcelKyoku(i, index));
        excel.updateCell(sheetName, cell(14, i - startIndex + topRow),
            histories[i + 1].pointSetting.riichibou * _setting.riichibouPoint);
      }

      var fileBytes = excel.save();

      File(join(folder, "$fileName.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);

      Fluttertoast.showToast(
        msg: i18n.generateSuccess(fileName),
        backgroundColor: Colors.blue,
      );
      OpenFile.open(join(folder, "$fileName.xlsx"));

      return true;
    }

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
                      (position) => PlayerNameInput(
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
                  generateExcel(
                    widget.start,
                    widget.end,
                    folder!,
                    fileName!,
                    sheetName!,
                    playerNames,
                  ).then((bool success) {
                    if (success) {
                      Navigator.of(context).popUntil(ModalRoute.withName('/'));
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
