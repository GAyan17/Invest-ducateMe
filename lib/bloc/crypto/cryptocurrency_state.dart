part of 'cryptocurrency_cubit.dart';

abstract class CryptocurrencyState extends Equatable {
  const CryptocurrencyState();

  @override
  List<Object> get props => [];
}

class CryptocurrencyInitial extends CryptocurrencyState {}
