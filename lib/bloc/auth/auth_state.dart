part of 'auth_bloc.dart';

enum AuthStatus {
  authenticated,
  unAuthenticated,
  authtenticationError,
  processing
}

class AuthState extends Equatable {
  final AuthStatus status;
  final AppUser? user;
  final String? errorMessage;

  const AuthState._({
    required this.status,
    this.user,
    this.errorMessage,
  });

  const AuthState.processing() : this._(status: AuthStatus.processing);

  const AuthState.authenticated({required AppUser user})
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unAuthenticated()
      : this._(status: AuthStatus.unAuthenticated);

  const AuthState.authenticationError({required String errorMessage})
      : this._(
            status: AuthStatus.authtenticationError,
            errorMessage: errorMessage);

  @override
  List<Object> get props => [status];

  @override
  String toString() {
    if (status == AuthStatus.authenticated) {
      return 'Authenticated';
    } else if (status == AuthStatus.unAuthenticated) {
      return 'UnAuthenticated';
    } else if (status == AuthStatus.authtenticationError) {
      return 'Authentication Error';
    } else {
      return 'Processing';
    }
  }
}
