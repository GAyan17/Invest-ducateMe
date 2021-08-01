part of 'login_cubit.dart';

class LoginFormCubitState extends Equatable {
  const LoginFormCubitState(
      {this.email = const EmailInput.pure(),
      this.password = const PasswordInput.pure(),
      this.status = FormzStatus.pure});

  final EmailInput email;
  final PasswordInput password;
  final FormzStatus status;

  @override
  List<Object> get props => [email, password, status];

  LoginFormCubitState copyWith(
      {EmailInput? emailInput,
      PasswordInput? passwordInput,
      FormzStatus? status}) {
    return LoginFormCubitState(
        email: emailInput ?? email,
        password: passwordInput ?? password,
        status: status ?? this.status);
  }
}
