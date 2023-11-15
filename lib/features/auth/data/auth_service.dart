import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      return (
        registred: false,
        error: e.code.replaceAll("_", " ").replaceAll("-", " ")
      );
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
      return (
        loggedIn: false,
        error: e.code.replaceAll("_", " ").replaceAll("-", " ")
      );
    } catch (e) {
      return (loggedIn: false, error: e.toString());
    }
  }

  Future<({String? error, bool? loggedIn})> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);

      return (loggedIn: true, error: null);
    } on FirebaseAuthException catch (e) {
      return (
        loggedIn: false,
        error: e.code.replaceAll("_", " ").replaceAll("-", " ")
      );
    } catch (e) {
      return (loggedIn: false, error: e.toString());
    }
  }

  Future<({String? error, bool? loggedIn})> loginWithGithub(
      BuildContext context) async {
    try {
      // Create a GitHubSignIn instance
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: dotenv.get("clientId"),
          clientSecret: dotenv.get("clientSecret"),
          redirectUrl: dotenv.get("redirectUrl"));

      // Trigger the sign-in flow
      final result = await gitHubSignIn.signIn(context);

      if (result.token == null) {
        return (loggedIn: false, error: result.errorMessage);
      }

      // Create a credential from the access token
      final githubAuthCredential = GithubAuthProvider.credential(result.token!);

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);

      return (loggedIn: true, error: null);
    } on FirebaseAuthException catch (e) {
      return (
        loggedIn: false,
        error: e.code.replaceAll("_", " ").replaceAll("-", " ")
      );
    } catch (e) {
      return (loggedIn: false, error: e.toString());
    }
  }

  bool get loggedIn => firebaseAuth.currentUser != null;
  String? get name => firebaseAuth.currentUser?.displayName;
}
