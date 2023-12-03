import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workout_app/app.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  ///--- Google ログイン ---///
  Future<void> signInWithGoogle(BuildContext context) async {
    const clientId =
        '320802277155-v5v9sk1da1fj7e45cchvv5hf4u7662bd.apps.googleusercontent.com';

    const scopes = ['openid', 'profile', 'email'];
    final request = GoogleSignIn(clientId: clientId, scopes: scopes);
    final response = await request.signIn();

    final authn = await response?.authentication;
    final acceseToken = authn?.accessToken;

    if (acceseToken == null) {
      debugPrint('accecetoken erorr');
      return;
    }else{
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BottomNavigation(),
        ),
            (route) => false,
      );
    }
    final oAuthCredential = GoogleAuthProvider.credential(
      accessToken: acceseToken,
    );
    await FirebaseAuth.instance.signInWithCredential(
      oAuthCredential,
    );
  }

  ///--- メール&パスワード ログイン ---///
  Future<void> signInWithEmailAndPassword(String email, String password) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
