import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Function for sign in (only for users with accounts in your application)
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

  // Function for sign up new users
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

  Future<String> getIdToken() async {
    print("Fetching Firebase ID Token...");
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not logged in');
    final cleanedToken =
        (await user.getIdToken())!.replaceAll(RegExp(r'\s+'), '');
    print("Firebase ID Token: $cleanedToken");
    return cleanedToken;
  }
}
