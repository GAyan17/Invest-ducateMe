import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';
import '../../data/repositories/crypto/investment_repo.dart';

part 'investment_state.dart';

class InvestmentCubit extends Cubit<InvestmentState> {
  final InvestmentRepository _investmentRepository;
  late StreamSubscription _investmentSubs;

  InvestmentCubit({required InvestmentRepository repository})
      : _investmentRepository = repository,
        super(const InvestmentState(investments: [])) {
    _investmentSubs = _investmentRepository
        .getInvestments()
        .listen((investments) => investmentFetched(investments));
  }

  void investmentFetched(List<Investment> investments) {
    emit(state.copyWith(investments: investments));
  }

  @override
  Future<void> close() {
    _investmentSubs.cancel();
    return super.close();
  }
}
