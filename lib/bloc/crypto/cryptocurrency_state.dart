part of 'cryptocurrency_cubit.dart';

abstract class CryptoCurrencyState extends Equatable {
  const CryptoCurrencyState();

  @override
  List<Object> get props => [];
}

class CryptoCurrencyInitial extends CryptoCurrencyState {}

class CryptoCurrenciesFetched extends CryptoCurrencyState {
  final List<CryptoCurrency> currencies;

  const CryptoCurrenciesFetched(this.currencies);

  @override
  List<Object> get props => [currencies];
}
