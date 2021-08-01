import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<User?> get userChanges {
    return _firebaseAuth.authStateChanges();
  }

  User? get currentUser => _firebaseAuth.currentUser;

  bool get isLoggedIn => currentUser == null ? false : true;

  String? get uid => isLoggedIn ? currentUser!.uid : null;

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw SignUpFailure(e.toString());
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw LogInFailure(e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw LogOutFailute(e.toString());
    }
  }
}

class LogOutFailute implements Exception {
  final String error;

  LogOutFailute(this.error);
}

class LogInFailure implements Exception {
  final String error;

  LogInFailure(this.error);
}

class SignUpFailure implements Exception {
  final String error;

  SignUpFailure(this.error);
}
