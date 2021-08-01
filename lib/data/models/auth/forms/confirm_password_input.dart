import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { invalid }

class ConfirmPasswordInput
    extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmPasswordInput.pure({this.password = ''}) : super.pure('');
  const ConfirmPasswordInput.dirty({required this.password, String value = ''})
      : super.dirty(value);

  final String password;

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    return password == value ? null : ConfirmPasswordValidationError.invalid;
  }
}
