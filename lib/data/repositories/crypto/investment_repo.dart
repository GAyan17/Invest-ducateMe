import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/models.dart';
import '../../../utils/constants.dart' as constants;

class InvestmentRepository {
  final FirebaseFirestore _firestore;
  final String _userId;
  late final CollectionReference<Investment> _collectionReference;

  InvestmentRepository({FirebaseFirestore? firestore, required String userId})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _userId = userId {
    _collectionReference = _firestore
        .collection(constants.userCollection)
        .doc(_userId)
        .collection(constants.investmentCollection)
        .withConverter<Investment>(
          fromFirestore: (snapshot, _) =>
              Investment.fromDocument(snapshot.data()!),
          toFirestore: (value, _) => value.toDocument(),
        );
  }

  Future<void> createInvestment(Investment investment) async {
    await _collectionReference.doc(investment.id).set(investment);
  }

  Stream<List<Investment>> getInvestments() {
    return _collectionReference
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }
}
