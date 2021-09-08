import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required AuthRepository authRepository,
      required AppUserRepository appUserRepository})
      : _authRepository = authRepository,
        _appUserRepository = appUserRepository,
        super(const AuthState.unAuthenticated());

  final AuthRepository _authRepository;
  final AppUserRepository _appUserRepository;
  // late final StreamSubscription _authSubscription;

  User? _currentUser;
  AppUser? _currentAppUser;

  AppUser get currentUser => _currentAppUser!;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is CheckLoggedIn) {
      yield const AuthState.processing();
      yield await _mapCheckLoggedInEventToState(event, state);
    } else if (event is SignUp) {
      yield const AuthState.processing();
      yield await _mapSignUpEventToState(event, state);
    } else if (event is LogIn) {
      yield const AuthState.processing();
      yield await _mapLogInEventToState(event, state);
    } else if (event is LogOut) {
      yield _mapLogOutEventToState(event, state);
    }
  }

  @override
  Future<void> close() {
    // _authSubscription.cancel();
    return super.close();
  }

  AuthState _mapLogOutEventToState(LogOut event, AuthState state) {
    _authRepository.logOut();
    return const AuthState.unAuthenticated();
  }

  Future<AuthState> _mapSignUpEventToState(
      SignUp event, AuthState state) async {
    try {
      await _authRepository.signUp(
          email: event.email, password: event.password);
      if (_authRepository.isLoggedIn) {
        _currentUser = _authRepository.currentUser;
        _currentAppUser = AppUser(
            id: _currentUser!.uid,
            name: event.name,
            email: _currentUser!.email!);
        await _appUserRepository.createUser(_currentAppUser!);
        return AuthState.authenticated(user: _currentAppUser!);
      } else {
        return const AuthState.authenticationError(
            errorMessage: 'User cannot be created');
      }
    } on SignUpFailure catch (e) {
      return AuthState.authenticationError(errorMessage: e.error);
    }
  }

  Future<AuthState> _mapLogInEventToState(LogIn event, AuthState state) async {
    try {
      await _authRepository.logIn(email: event.email, password: event.password);
      if (_authRepository.isLoggedIn) {
        _currentUser = _authRepository.currentUser;
        _currentAppUser = await _appUserRepository.getUser(_currentUser!.uid);
        return AuthState.authenticated(user: _currentAppUser!);
      } else {
        return const AuthState.authenticationError(
            errorMessage: 'User cannot be logged in');
      }
    } on LogInFailure catch (e) {
      return AuthState.authenticationError(errorMessage: e.error);
    }
  }

  Future<AuthState> _mapCheckLoggedInEventToState(
      CheckLoggedIn event, AuthState state) async {
    if (_authRepository.isLoggedIn) {
      try {
        _currentUser = _authRepository.currentUser;
        _currentAppUser = await _appUserRepository.getUser(_currentUser!.uid);
        return AuthState.authenticated(user: _currentAppUser!);
      } on UserNotCreated {
        return const AuthState.authenticationError(
            errorMessage: 'User is not created!');
      }
    } else {
      return const AuthState.unAuthenticated();
    }
  }
}
