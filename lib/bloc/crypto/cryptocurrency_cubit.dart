import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';
import '../../data/repositories/crypto/crypto_repo.dart';

part 'cryptocurrency_state.dart';

class CryptoCurrencyCubit extends Cubit<CryptoCurrencyState> {
  CryptoCurrencyCubit({required CryptoCurrencyRepository repository})
      : _cryptoRepository = repository,
        super(CryptoCurrencyInitial()) {
    getCurrencies();
  }

  final CryptoCurrencyRepository _cryptoRepository;

  Future<void> getCurrencies() async {
    emit(CryptoCurrenciesFetched(await _cryptoRepository.getListing()));
  }
}
