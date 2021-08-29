import 'package:cloud_firestore/cloud_firestore.dart';

import '../.././../utils/constants.dart' as constants;
import '../../models/models.dart';

class TransactionRepository {
  final FirebaseFirestore _firestore;
  final String _userId;
  late final CollectionReference<WithdrawTransacton> _withdrawColRef;
  late final CollectionReference<InvestTransaction> _investTransColRef;

  TransactionRepository({FirebaseFirestore? firestore, required String userId})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _userId = userId {
    _withdrawColRef = _firestore
        .collection(constants.userCollection)
        .doc(_userId)
        .collection(constants.withdrawTransaction)
        .withConverter<WithdrawTransacton>(
          fromFirestore: (snapshot, _) =>
              WithdrawTransacton.fromDocument(snapshot.data()!),
          toFirestore: (value, _) => value.toDocument(),
        );

    _investTransColRef = _firestore
        .collection(constants.userCollection)
        .doc(_userId)
        .collection(constants.investTransaction)
        .withConverter<InvestTransaction>(
          fromFirestore: (snapshot, _) =>
              InvestTransaction.fromDocument(snapshot.data()!),
          toFirestore: (value, _) => value.toDocument(),
        );
  }

  Future<void> createWithdrawTransaction(
      WithdrawTransacton withdrawTransacton) async {
    await _withdrawColRef.doc(withdrawTransacton.id).set(withdrawTransacton);
  }

  Future<void> createInvestTransaction(
      InvestTransaction investTransaction) async {
    await _investTransColRef.doc(investTransaction.id).set(investTransaction);
  }

  Future<void> updateWithdrawTransaction(
      WithdrawTransacton withdrawTransacton) async {
    await _withdrawColRef.doc(withdrawTransacton.id).set(withdrawTransacton);
  }

  Future<void> updateInvestTransaction(
      InvestTransaction investTransaction) async {
    await _investTransColRef.doc(investTransaction.id).set(investTransaction);
  }

  Stream<List<WithdrawTransacton>> getWithdrawTransactions() {
    return _withdrawColRef
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  Stream<List<InvestTransaction>> getInvestTransactions() {
    return _investTransColRef
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }
}
