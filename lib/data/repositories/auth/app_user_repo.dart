import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/models.dart';

import '../../../utils/constants.dart' as constants;

class AppUserRepository {
  final FirebaseFirestore _firestore;

  AppUserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createUser(AppUser user) async {
    await _firestore
        .collection(constants.userCollection)
        .doc(user.id)
        .set(user.toDocument());
  }

  Future<AppUser> getUser(String id) async {
    var userSnapshot =
        await _firestore.collection(constants.userCollection).doc(id).get();
    if (userSnapshot.exists) {
      return AppUser.fromDocument(userSnapshot.data()!);
    } else {
      throw UserNotCreated(id);
    }
  }

  Future<void> updateUser(String id, AppUser user) async {
    await _firestore
        .collection(constants.userCollection)
        .doc(id)
        .update(user.toDocument());
  }
}

class UserNotCreated implements Exception {
  final String message;

  UserNotCreated(String id) : message = "User was not created with $id";
}
