import 'package:firebase_auth/firebase_auth.dart';
abstract class AuthRepository{
  User? get currentUser;

  Future<String?> signUp({
    required String email,
    required String password,
  });

  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
}