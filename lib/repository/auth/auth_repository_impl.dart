import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workout_app/app.dart';
import 'package:workout_app/repository/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user?.uid;
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }


  ///--- Google ログイン ---///
  @override
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
    await _auth.signInWithCredential(
      oAuthCredential,
    );
  }

  @override
  Future<void> signOut() async{
    await _auth.signOut();
}
}
