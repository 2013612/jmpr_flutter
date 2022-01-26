import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/game.dart';

class GameRepository {
  final CollectionReference<Game> collection = FirebaseFirestore.instance
      .collection('games')
      .withConverter<Game>(
          fromFirestore: (snapshot, _) =>
              Game.fromJson(snapshot.data() as Map<String, dynamic>),
          toFirestore: (game, _) => game.toJson());

  Stream<QuerySnapshot<Game>> listGamesStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addGame(Game game) async {
    return collection.add(game);
  }
}
