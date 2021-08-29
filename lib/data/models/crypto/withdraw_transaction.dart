import 'package:equatable/equatable.dart';

class WithdrawTransacton extends Equatable {
  final String id;
  final int cmpId;
  final String symbol;
  final String name;
  final num amountRecieve;
  final num tokenAmount;
  final DateTime timeStamp;

  const WithdrawTransacton({
    required this.id,
    required this.cmpId,
    required this.symbol,
    required this.name,
    required this.amountRecieve,
    required this.tokenAmount,
    required this.timeStamp,
  });

  @override
  List<Object?> get props => [
        id,
        cmpId,
        symbol,
        name,
        amountRecieve,
        tokenAmount,
        timeStamp,
      ];

  factory WithdrawTransacton.fromDocument(Map<String, dynamic> data) =>
      WithdrawTransacton(
        id: data['id'],
        cmpId: data['cmp_id'],
        symbol: data['symbol'],
        name: data['name'],
        amountRecieve: data['amount_recieve'],
        tokenAmount: data['token_amount'],
        timeStamp: data['timestamp'],
      );

  Map<String, dynamic> toDocument() => {
        'id': id,
        'cmp_id': cmpId,
        'symbol': symbol,
        'name': name,
        'amount_recieve': amountRecieve,
        'token_amount': tokenAmount,
        'timestamp': timeStamp,
      };
}
