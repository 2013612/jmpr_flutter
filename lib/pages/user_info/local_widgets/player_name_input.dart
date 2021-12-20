import 'package:flutter/material.dart';

import '../../../common_widgets/row_input.dart';
import '../../../models/game_player.dart';
import '../../../models/user.dart';
import '../../../utility/constant.dart';
import '../../../utility/enum/position.dart';

class PlayerNameInput extends StatelessWidget {
  final List<GamePlayer> gamePlayers;
  final int index;
  final List<User> users;

  const PlayerNameInput(
      {Key? key,
      required this.gamePlayers,
      required this.users,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowInput(
      name: Constant.positionTexts[Position.values[index]]!,
      widget: Autocomplete<User>(
        displayStringForOption: (User user) => user.displayName ?? "",
        initialValue: TextEditingValue(
            text: users
                    .firstWhere((user) => user.uid == gamePlayers[index].uid,
                        orElse: () => User(uid: ""))
                    .displayName ??
                ""),
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<User>.empty();
          }
          return users.where((User option) =>
              gamePlayers.every((gamePlayer) => option.uid != gamePlayer.uid) &&
              option.displayName != null &&
              option.displayName!
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()));
        },
        onSelected: (User user) {
          gamePlayers[index] =
              GamePlayer(uid: user.uid, displayName: user.displayName ?? "");
        },
        fieldViewBuilder: (_, ctrl, focusNode, onFieldSubmitted) =>
            TextFormField(
          controller: ctrl,
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
          onChanged: (input) =>
              gamePlayers[index] = GamePlayer(uid: "", displayName: input),
          validator: (_) {
            print(index);
          },
        ),
      ),
      icon: Constant.arrows[Position.values[index]],
    );
  }
}
