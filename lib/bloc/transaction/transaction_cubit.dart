import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';
import '../../data/repositories/crypto/transaction_repo.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository,
        super(const TransactionState(
            investTransactions: [], withdrawTransactions: [])) {
    _investTransactionsSub = _transactionRepository
        .getInvestTransactions()
        .listen((investTransactions) =>
            investTransactionsFetched(investTransactions));

    _withdrawTransactionsSub = _transactionRepository
        .getWithdrawTransactions()
        .listen((withdrawTransactions) =>
            withdrawTransactionFetched(withdrawTransactions));
  }

  final TransactionRepository _transactionRepository;
  late StreamSubscription _investTransactionsSub;
  late StreamSubscription _withdrawTransactionsSub;

  void investTransactionsFetched(List<InvestTransaction> investTransactions) {
    emit(state.copyWith(investTransactions: investTransactions));
  }

  void withdrawTransactionFetched(
      List<WithdrawTransacton> withdrawTransactions) {
    emit(state.copyWith(withdrawTransactions: withdrawTransactions));
  }

  Future<void> createInvestTransaction(
      InvestTransaction investTransaction) async {
    await _transactionRepository.createInvestTransaction(investTransaction);
  }

  Future<void> createWithdrawTransaction(
      WithdrawTransacton withdrawTransacton) async {
    await _transactionRepository.createWithdrawTransaction(withdrawTransacton);
  }

  @override
  Future<void> close() {
    _investTransactionsSub.cancel();
    _withdrawTransactionsSub.cancel();
    return super.close();
  }
}
