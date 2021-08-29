part of 'investment_cubit.dart';

class InvestmentState extends Equatable {
  final List<Investment> investments;

  const InvestmentState({required this.investments});

  InvestmentState copyWith({List<Investment>? investments}) =>
      InvestmentState(investments: investments ?? this.investments);

  @override
  List<Object> get props => [investments];
}
