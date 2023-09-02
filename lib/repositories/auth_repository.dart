import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  User? get currentUser => _auth.currentUser;
  AuthRepository({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Register with email and password

  Future<User?> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'password-too-weak') {
        throw Exception("Your password too weak!");
      } else if (e.code == 'email-already-in-use') {
        throw Exception("Email is already in use!");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  // Sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
