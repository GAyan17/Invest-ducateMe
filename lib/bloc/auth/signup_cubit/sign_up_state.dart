part of 'sign_up_cubit.dart';

class SignUpFormCubitState extends Equatable {
  const SignUpFormCubitState({
    this.name = const NameInput.pure(),
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.confirmPassword = const ConfirmPasswordInput.pure(),
    this.status = FormzStatus.pure,
  });

  final NameInput name;
  final EmailInput email;
  final PasswordInput password;
  final ConfirmPasswordInput confirmPassword;
  final FormzStatus status;

  @override
  List<Object> get props => [name, email, password, confirmPassword, status];

  SignUpFormCubitState copyWith({
    NameInput? nameInput,
    EmailInput? emailInput,
    PasswordInput? passwordInput,
    ConfirmPasswordInput? confirmPasswordInput,
    FormzStatus? status,
  }) {
    return SignUpFormCubitState(
        name: nameInput ?? name,
        email: emailInput ?? email,
        password: passwordInput ?? password,
        confirmPassword: confirmPasswordInput ?? confirmPassword,
        status: status ?? this.status);
  }
}
