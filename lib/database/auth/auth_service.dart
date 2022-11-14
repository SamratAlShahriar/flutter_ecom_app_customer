import 'package:firebase_auth/firebase_auth.dart';

import '../firebase_db_helper.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<UserCredential> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credential;
  }

  static Future<UserCredential> register(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credential;
  }

  static Future<UserCredential> loginAsGuest() async {
    return await _auth.signInAnonymously();
  }

  static Future<void> resetPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  static Future<void> logout() async => await _auth.signOut();
}
