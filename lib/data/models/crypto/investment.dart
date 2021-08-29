import 'package:equatable/equatable.dart';

class Investment extends Equatable {
  final String id;
  final int cmpId;
  final String name;
  final String symbol;
  final num qoutePriceUSD;
  final num amountToken;
  final num finalPriceUSD;
  final bool isWithdrawn;

  const Investment({
    required this.id,
    required this.cmpId,
    required this.name,
    required this.symbol,
    required this.qoutePriceUSD,
    required this.amountToken,
    required this.finalPriceUSD,
    this.isWithdrawn = false,
  });

  @override
  List<Object?> get props => [
        id,
        cmpId,
        name,
        symbol,
        qoutePriceUSD,
        amountToken,
        finalPriceUSD,
        isWithdrawn,
      ];

  factory Investment.fromDocument(Map<String, dynamic> data) => Investment(
        id: data['id'],
        cmpId: data['cmp_id'],
        name: data['name'],
        symbol: data['symbol'],
        qoutePriceUSD: data['qoute_price_USD'],
        amountToken: data['amount_token'],
        finalPriceUSD: data['final_price_USD'],
      );

  Map<String, dynamic> toDocument() => {
        'id': id,
        'cmp_id': cmpId,
        'name': name,
        'symbol': symbol,
        'qoute_price_USD': qoutePriceUSD,
        'amount_token': amountToken,
        'final_price_USD': finalPriceUSD,
      };
}
