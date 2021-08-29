import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/models.dart';

import '../../../utils/constants.dart' as constants;

class AppUserRepository {
  final FirebaseFirestore _firestore;
  late final CollectionReference<AppUser> _collectionReference;

  AppUserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _collectionReference =
        _firestore.collection(constants.userCollection).withConverter<AppUser>(
              fromFirestore: (snapshot, _) =>
                  AppUser.fromDocument(snapshot.data()!),
              toFirestore: (value, _) => value.toDocument(),
            );
  }

  Future<void> createUser(AppUser user) async {
    await _collectionReference.doc(user.id).set(user);
    // await _firestore
    //     .collection(constants.userCollection)
    //     .doc(user.id)
    //     .set(user.toDocument());
  }

  Future<AppUser> getUser(String id) async {
    var userSnapshot = await _collectionReference.doc(id).get();
    // var userSnapshot =
    //     await _firestore.collection(constants.userCollection).doc(id).get();
    if (userSnapshot.exists) {
      return userSnapshot.data()!;
    } else {
      throw UserNotCreated(id);
    }
  }

  Future<void> updateUser(String id, AppUser user) async {
    await _collectionReference.doc(id).set(user);
    // await _firestore
    //     .collection(constants.userCollection)
    //     .doc(id)
    //     .update(user.toDocument());
  }
}

class UserNotCreated implements Exception {
  final String message;

  UserNotCreated(String id) : message = "User was not created with $id";
}
