import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/app_constant.dart';

class AuthService {
  final FirebaseAuth firebaseAuth;

  AuthService({required this.firebaseAuth});

  Future<({String? error, bool? registred})> register(
      {required String email, required String password}) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User? user = firebaseAuth.currentUser;
        await user?.updateDisplayName(generateRandomUsername());
        await user?.reload();
      });
      return (registred: true, error: null);
    } on FirebaseAuthException catch (e) {
      return (registred: false, error: e.message);
    } catch (e) {
      return (registred: false, error: e.toString());
    }
  }

  Future<({String? error, bool? loggedIn})> login(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return (loggedIn: true, error: null);
    } on FirebaseAuthException catch (e) {
      return (loggedIn: false, error: e.message);
    } catch (e) {
      return (loggedIn: false, error: e.toString());
    }
  }

  bool get loggedIn => firebaseAuth.currentUser != null;
}
