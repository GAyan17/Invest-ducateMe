import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cryptocurrency_state.dart';

class CryptocurrencyCubit extends Cubit<CryptocurrencyState> {
  CryptocurrencyCubit() : super(CryptocurrencyInitial());
}
