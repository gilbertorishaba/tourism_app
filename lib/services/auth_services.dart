import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Sign-In function
  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Sign-in failed: $e');
      rethrow;
    }
  }

  // Sign-Up function
  Future<UserCredential> signUp(String email, String password) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Sign-up failed: $e');
      rethrow;
    }
  }

  // Sign-Out function (optional)
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
