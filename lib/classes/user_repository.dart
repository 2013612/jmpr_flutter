import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserRepository {
  final CollectionReference<User> collection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromSnapshot(snapshot),
          toFirestore: (user, _) => user.toJson());

  Stream<QuerySnapshot<User>> getUserStream(String uid) {
    return collection.where("uid", isEqualTo: uid).snapshots();
  }

  Stream<QuerySnapshot<User>> listUsersStream() {
    return collection.snapshots();
  }

  Future<QuerySnapshot<User>> getUserByName(String displayName) {
    return collection.where("display_name", isEqualTo: displayName).get();
  }

  Future<DocumentReference> addUser(User user) async {
    final existUser = await getUserByName(user.displayName ?? "");
    if (existUser.docs.isNotEmpty) {
      user = user.copyWith(displayName: "${user.displayName!}#2");
    }
    return collection.add(user);
  }
}
