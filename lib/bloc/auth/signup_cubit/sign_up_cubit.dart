import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../data/models/models.dart';

part 'sign_up_state.dart';

class SignUpFormCubit extends Cubit<SignUpFormCubitState> {
  SignUpFormCubit() : super(const SignUpFormCubitState());

  void nameChanged(String value) {
    final name = NameInput.dirty(value);
    emit(state.copyWith(
      nameInput: name,
      status: Formz.validate(
          [name, state.email, state.password, state.confirmPassword]),
    ));
  }

  void emailChanged(String value) {
    final email = EmailInput.dirty(value);
    emit(state.copyWith(
      emailInput: email,
      status: Formz.validate(
          [state.name, email, state.password, state.confirmPassword]),
    ));
  }

  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value);
    final confirmPassword = ConfirmPasswordInput.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );

    emit(state.copyWith(
      passwordInput: password,
      confirmPasswordInput: confirmPassword,
      status:
          Formz.validate([state.name, state.email, password, confirmPassword]),
    ));
  }

  void confirmPasswordChange(String value) {
    final confirmPassword = ConfirmPasswordInput.dirty(
      password: state.password.value,
      value: value,
    );

    emit(state.copyWith(
      confirmPasswordInput: confirmPassword,
      status: Formz.validate(
          [state.name, state.email, state.password, confirmPassword]),
    ));
  }

  bool get isValid => state.status.isValid;
}
