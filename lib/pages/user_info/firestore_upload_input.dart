import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common_widgets/base_bar_button.dart';
import '../../common_widgets/row_input.dart';
import '../../common_widgets/text_input.dart';
import '../../firestore_repositories/game_repository.dart';
import '../../firestore_repositories/user_repository.dart';
import '../../models/game.dart';
import '../../models/user.dart';
import '../../utility/constant.dart';
import '../../utility/enum/position.dart';
import '../../utility/iterable_methods.dart';
import '../../utility/validators.dart';
import 'local_widgets/player_name_input.dart';

class FirestoreUploadInput extends ConsumerStatefulWidget {
  final Game game;

  FirestoreUploadInput(this.game);

  @override
  _FirestoreUploadInputState createState() => _FirestoreUploadInputState();
}

class _FirestoreUploadInputState extends ConsumerState<FirestoreUploadInput> {
  final _playerNameFormKey = GlobalKey<FormState>();
  final _pathFormKey = GlobalKey<FormState>();
  final UserRepository userRepository = UserRepository();
  final GameRepository gameRepository = GameRepository();
  final TextEditingController _folderController = TextEditingController();
  late final Game game;
  String folder = "", fileName = "", sheetName = "";

  @override
  void initState() {
    super.initState();
    game = widget.game.copyWith();
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
          child: StreamBuilder<QuerySnapshot<User>>(
            stream: userRepository.listUsersStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final users =
                    snapshot.data!.docs.map((fsUser) => fsUser.data()).toList();
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Form(
                      key: _playerNameFormKey,
                      child: Column(
                        children: game.gamePlayers
                            .mapIndexed(
                              (_, index) => PlayerNameInput(
                                gamePlayers: game.gamePlayers,
                                index: index,
                                users: users,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Divider(),
                    Form(
                      key: _pathFormKey,
                      child: Column(
                        children: [
                          RowInput(
                            name: i18n.folder,
                            widget: TextFormField(
                              readOnly: true,
                              controller: _folderController,
                              onTap: () async {
                                final extDirPath = Directory(await ExtStorage
                                        .getExternalStorageDirectory() ??
                                    "");
                                final path = await (FilesystemPicker.open(
                                  title: "Save to folder",
                                  context: context,
                                  rootDirectory: Directory(extDirPath.path),
                                  fsType: FilesystemType.folder,
                                  pickText: "Save file to this folder",
                                  requestPermission: () async =>
                                      await Permission.storage
                                          .request()
                                          .isGranted,
                                ));
                                _folderController.text = path ?? "";
                              },
                              onSaved: (String? path) => folder = path ?? "",
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
                                    onSaved: (String? name) =>
                                        fileName = name ?? "",
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
                              onSaved: (String? name) => sheetName = name ?? "",
                              validator: Validators.empty,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }

              if (snapshot.hasError) {
                print(snapshot.error);
              }

              return const CircularProgressIndicator();
            },
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
              name: "to xslx",
              onPress: () {
                if ((_playerNameFormKey.currentState?.validate() ?? false) &&
                    (_pathFormKey.currentState?.validate() ?? false)) {
                  _playerNameFormKey.currentState!.save();
                  _pathFormKey.currentState!.save();
                  createExcelFile(context).then((excel) {
                    if (excel != null) {
                      generateExcelContent(excel, context).then((isSuccess) {
                        if (isSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("success"),
                            ),
                          );
                          OpenFile.open(join(folder, "$fileName.xlsx"));
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("fail"),
                        ),
                      );
                    }
                  });
                }
              },
            ),
            BaseBarButton(
              name: "to firestore",
              onPress: () {
                if (_playerNameFormKey.currentState!.validate()) {
                  gameRepository
                      .addGame(game.copyWith(createdAt: DateTime.now()))
                      .then(
                    (_) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("success"),
                      ),
                    ),
                    onError: (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("fail"),
                        ),
                      );
                      print(error);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Excel?> createExcelFile(
    BuildContext context,
  ) async {
    final i18n = AppLocalizations.of(context)!;
    Excel? excel;
    try {
      final bytes = File(join(folder, "$fileName.xlsx")).readAsBytesSync();
      excel = Excel.decodeBytes(bytes);
      if (excel.tables.keys.contains(sheetName)) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(i18n.warningExistingSheetName(sheetName, fileName)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(i18n.cancel),
              ),
              TextButton(
                onPressed: () {
                  OpenFile.open(join(folder, "$fileName.xlsx"));
                  Navigator.pop(context);
                },
                child: Text(i18n.openExcel(fileName)),
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

  Future<bool> generateExcelContent(
    Excel excel,
    BuildContext context,
  ) async {
    final i18n = AppLocalizations.of(context)!;

    final transactions = game.transactions;
    final pointSettings = game.pointSettings;
    final setting = game.setting;

    CellIndex cell(int col, int row) {
      return CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row);
    }

    Position position(int index) {
      return Position.values[(setting.firstOya.index + index) % 4];
    }

    Map<Position, double> marks = pointSettings.last.calResult(setting);

    const int topRow = 2;
    const int frontColumn = 4;
    excel.merge(sheetName, cell(0, 1), cell(1, 1), customValue: i18n.kyoku);
    excel.updateCell(sheetName, cell(2, 1), i18n.oya);
    excel.updateCell(sheetName, cell(3, 1), i18n.kyoutaku);
    List.generate(4, (index) {
      excel.merge(sheetName, cell(frontColumn + 3 * index, 0),
          cell(frontColumn + 2 + 3 * index, 0),
          customValue: game
              .gamePlayers[(setting.firstOya.index + index) % 4].displayName);
      excel.updateCell(
          sheetName, cell(frontColumn + 3 * index, 1), i18n.riichi);
      excel.updateCell(
          sheetName, cell(frontColumn + 1 + 3 * index, 1), i18n.pointVariation);
      excel.updateCell(
          sheetName, cell(frontColumn + 2 + 3 * index, 1), i18n.currentPoint);
      excel.updateCell(
          sheetName,
          cell(frontColumn + 2 + 3 * index, pointSettings.length - 1 + topRow),
          pointSettings.last.players[position(index)]!.point);
      excel.updateCell(
          sheetName,
          cell(frontColumn + 2 + 3 * index, pointSettings.length + topRow),
          marks[position(index)]);
    });

    void updateExcelPlayerKyoku(int ind, int pos) {
      excel.updateCell(
          sheetName,
          cell(frontColumn + pos * 3, ind + topRow),
          transactions[ind]
              .playerPoints[position(pos)]!
              .isRiichi
              .toString()
              .toUpperCase());
      excel.updateCell(sheetName, cell(frontColumn + 1 + pos * 3, ind + topRow),
          transactions[ind].playerPoints[position(pos)]?.point ?? 0);
      excel.updateCell(sheetName, cell(frontColumn + 2 + pos * 3, ind + topRow),
          pointSettings[ind + 1].players[position(pos)]?.point ?? 0);
    }

    for (int i = 0; i < pointSettings.length - 1; i++) {
      excel.updateCell(sheetName, cell(0, i + topRow),
          Constant.kyokus[pointSettings[i].currentKyoku]);
      excel.updateCell(sheetName, cell(1, i + topRow),
          "${pointSettings[i].bonba}${i18n.bonba}");
      excel.updateCell(
          sheetName,
          cell(2, i + topRow),
          game
              .gamePlayers[
                  (setting.firstOya.index + pointSettings[i].currentKyoku) % 4]
              .displayName);
      List.generate(4, (index) => updateExcelPlayerKyoku(i, index));
      excel.updateCell(sheetName, cell(3, i + topRow),
          pointSettings[i].riichibou * setting.riichibouPoint);
    }

    try {
      final fileBytes = excel.save();
      File(join(folder, "$fileName.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);
      return true;
    } on FileSystemException catch (e) {
      print(e);
      return false;
    }
  }
}
