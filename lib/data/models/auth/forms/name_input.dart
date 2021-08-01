import 'package:formz/formz.dart';

enum NameInputValidationError { invalid }

class NameInput extends FormzInput<String, NameInputValidationError> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([String value = '']) : super.dirty(value);

  @override
  NameInputValidationError? validator(String value) {
    return value.isNotEmpty ? null : NameInputValidationError.invalid;
  }
}
