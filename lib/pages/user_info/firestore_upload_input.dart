import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../classes/game_repository.dart';

import '../../classes/user_repository.dart';
import '../../common_widgets/base_bar_button.dart';
import '../../models/game.dart';
import '../../models/game_player.dart';
import '../../models/user.dart';
import '../../providers/histories.dart';
import '../../utility/iterable_methods.dart';
import 'local_widgets/player_name_input.dart';

class FirestoreUploadInput extends ConsumerStatefulWidget {
  final Game game;
  final int start;
  final int end;

  FirestoreUploadInput(this.game, this.start, this.end);

  @override
  _FirestoreUploadInputState createState() => _FirestoreUploadInputState();
}

class _FirestoreUploadInputState extends ConsumerState<FirestoreUploadInput> {
  final _userInputFormKey = GlobalKey<FormState>();
  final UserRepository userRepository = UserRepository();
  final GameRepository gameRepository = GameRepository();
  late final Game game;

  @override
  void initState() {
    super.initState();
    game = Game(
      gamePlayers:
          List.generate(4, (_) => GamePlayer(displayName: '', uid: '')),
      histories:
          widget.game.histories.getRange(widget.start, widget.end).toList(),
      createdAt: DateTime.now(),
      setting: widget.game.setting,
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

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
            child: StreamBuilder<QuerySnapshot<User>>(
              stream: userRepository.listUsersStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final users = snapshot.data!.docs
                      .map((fsUser) => fsUser.data())
                      .toList();
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      ...game.gamePlayers
                          .mapIndexed(
                            (_, index) => PlayerNameInput(
                              gamePlayers: game.gamePlayers,
                              index: index,
                              users: users,
                            ),
                          )
                          .toList(),
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
              name: "to firestore",
              onPress: () {
                if (_userInputFormKey.currentState!.validate()) {
                  // print("hi");
                  // _userInputFormKey.currentState!.save();
                  gameRepository
                      .addGame(game.copyWith(createdAt: DateTime.now()))
                      .then((_) =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("success"),
                          )))
                      .catchError(print);
                }
              },
            ),
            // BaseBarButton(name: "to xlsx", onPress: () {
            //
            // })
          ],
        ),
      ),
    );
  }
}
