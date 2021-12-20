import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa_user;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    required String uid,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'photo_url') String? photoURL,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromFireAuth(fa_user.User user) {
    return User(
      uid: user.uid,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    return User.fromJson(snapshot.data() as Map<String, dynamic>);
  }
}
