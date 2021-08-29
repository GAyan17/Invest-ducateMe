part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  final List<InvestTransaction> investTransactions;
  final List<WithdrawTransacton> withdrawTransactions;

  const TransactionState({
    required this.investTransactions,
    required this.withdrawTransactions,
  });

  TransactionState copyWith(
          {List<InvestTransaction>? investTransactions,
          List<WithdrawTransacton>? withdrawTransactions}) =>
      TransactionState(
        investTransactions: investTransactions ?? this.investTransactions,
        withdrawTransactions: withdrawTransactions ?? this.withdrawTransactions,
      );

  @override
  List<Object> get props => [investTransactions, withdrawTransactions];
}
