import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../classes/user.dart';
import '../classes/user_repository.dart';

final userStreamProvider =
    StreamProvider.autoDispose.family<QuerySnapshot<User>, String>((_, uid) {
  final userRepository = UserRepository();
  return userRepository.getUserStream(uid);
});
