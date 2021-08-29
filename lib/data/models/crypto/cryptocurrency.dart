import 'package:equatable/equatable.dart';

class CryptoCurrency extends Equatable {
  final int id;
  final String name;
  final String symbol;
  final num qoutePriceUSD;
  final num percentChange1h;
  final num percentChange24h;
  final num percentChange7d;

  const CryptoCurrency(
      {required this.id,
      required this.name,
      required this.symbol,
      required this.qoutePriceUSD,
      required this.percentChange1h,
      required this.percentChange24h,
      required this.percentChange7d});

  factory CryptoCurrency.fromJSON(Map<String, dynamic> json) {
    // print('ID: ${json['id']}\n');
    // print('Name: ${json['name']}\n');
    // print('Symbol: ${json['symbol']}\n');
    // print('Price: ${json['quote']['USD']['price']}\n');
    // print('1h: ${json['quote']['USD']['percent_change_1h']}\n');
    // print('24h: ${json['quote']['USD']['percent_change_24h']}\n');
    // print('1d: ${json['quote']['USD']['percent_change_7d']}\n');
    return CryptoCurrency(
      id: json['id'] as int,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      qoutePriceUSD: json['quote']['USD']['price'] as double,
      percentChange1h: json['quote']['USD']['percent_change_1h'] as double,
      percentChange24h: json['quote']['USD']['percent_change_24h'] as double,
      percentChange7d: json['quote']['USD']['percent_change_7d'] as double,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        symbol,
        qoutePriceUSD,
        percentChange1h,
        percentChange24h,
        percentChange24h,
      ];
}
