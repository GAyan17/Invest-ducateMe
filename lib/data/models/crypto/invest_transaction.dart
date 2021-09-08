import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class InvestTransaction extends Equatable {
  final String id;
  final int cmpId;
  final String symbol;
  final String name;
  final num amountSpend;
  final num tokenAmount;
  final num tokens;
  final DateTime timeStamp;

  const InvestTransaction({
    required this.id,
    required this.cmpId,
    required this.symbol,
    required this.name,
    required this.amountSpend,
    required this.tokenAmount,
    required this.tokens,
    required this.timeStamp,
  });

  @override
  List<Object?> get props => [
        id,
        cmpId,
        symbol,
        name,
        amountSpend,
        tokenAmount,
        tokens,
        timeStamp,
      ];

  factory InvestTransaction.fromDocument(Map<String, dynamic> data) =>
      InvestTransaction(
        id: data['id'],
        cmpId: data['cmp_id'],
        symbol: data['symbol'],
        name: data['name'],
        amountSpend: data['amount_spend'],
        tokenAmount: data['token_amount'],
        tokens: data['tokens'],
        timeStamp: DateTime.parse(
            (data['timestamp'] as Timestamp).toDate().toString()),
      );

  Map<String, dynamic> toDocument() => {
        'id': id,
        'cmp_id': cmpId,
        'symbol': symbol,
        'name': name,
        'amount_spend': amountSpend,
        'token_amount': tokenAmount,
        'tokens': tokens,
        'timestamp': timeStamp,
      };
}
