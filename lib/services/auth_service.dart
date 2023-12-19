import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserCredential> login(String email, String password) async {
    try {
      // Per the assignment instructions, using anonymous sign in to keep things simple.
      // In the real world, the user would register and then use the email
      // and password to log in.
      return await _firebaseAuth.signInAnonymously();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
