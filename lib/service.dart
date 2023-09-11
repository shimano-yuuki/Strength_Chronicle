import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  Future<void> signIn() async {
    debugPrint('サービスクラスが動き出しました');
    const clientId = '320802277155-bt9dh0pkkuddsn1btvu4bdrcq04flujf.apps.googleusercontent.com';

    const scopes = [
      'openid',
      'profile',
      'email'
    ];

    final request = GoogleSignIn(clientId: clientId,scopes: scopes);
    final response = await request.signIn();

    final authn = await response?.authentication;
    final acceseToken = authn?.accessToken;

    if(acceseToken == null){
      return;
    }
    final oAuthCredential = GoogleAuthProvider.credential(
      accessToken: acceseToken,
    );
    await FirebaseAuth.instance.signInWithCredential(
      oAuthCredential,
    );
  }
  Future<void> signOut()async{
    await FirebaseAuth.instance.signOut();
  }
}