import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../firebase_db_helper.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static GoogleSignInAccount? _googleUser;

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

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    _googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await _googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  static Future<UserCredential> loginAsGuest() async {
    return await _auth.signInAnonymously();
  }

  static Future<void> resetPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  static Future<void> logout() async {
    try {
      if (currentUser != null && currentUser!.isAnonymous) {
        return await currentUser!.delete();
      }

      if (_googleUser != null) {
        await GoogleSignIn().signOut();
      }

      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
    }
  }
}
