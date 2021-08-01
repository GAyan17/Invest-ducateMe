part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class CheckLoggedIn extends AuthEvent {
  const CheckLoggedIn();

  @override
  List<Object?> get props => [];
}

class LogIn extends AuthEvent {
  final String email;
  final String password;

  const LogIn(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUp(this.name, this.email, this.password);

  @override
  List<Object?> get props => [name, email, password];
}

class LogOut extends AuthEvent {
  @override
  List<Object?> get props => [];
}
