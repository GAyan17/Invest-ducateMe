import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../data/models/models.dart';

part 'login_state.dart';

class LoginFormCubit extends Cubit<LoginFormCubitState> {
  LoginFormCubit() : super(const LoginFormCubitState());

  void emailChanged(String value) {
    final email = EmailInput.dirty(value);
    emit(state.copyWith(
      emailInput: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void passwordChange(String value) {
    final password = PasswordInput.dirty(value);
    emit(state.copyWith(
      passwordInput: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  bool get isValid => state.status.isValid;
}
