import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as faUser;

class User {
  String uid;
  String? displayName;
  String? photoURL;

  User({required this.uid, this.displayName, this.photoURL});

  factory User.fromFireAuth(faUser.User user) {
    print(user);
    return User(
      uid: user.uid,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
      uid: json["uid"] as String,
      displayName: json["display_name"] as String?,
      photoURL: json["photo_url"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "display_name": displayName,
      "photo_url": photoURL,
    };
  }

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot);
    return User.fromJson(snapshot.data() as Map<String, dynamic>);
  }
}
