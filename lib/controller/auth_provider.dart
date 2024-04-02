import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/service/auth_service.dart';

class AuthProviders extends ChangeNotifier {
  Future<UserCredential>? user;
  AuthService authService = AuthService();
  signInWithEmail(String email, String password, BuildContext context) {
    return authService.signInWithEmailAndPassword(email, password, context);
  }

  signUpWithEmail(String email, String password, String name) {
    return authService.signUpWithEmailAndPassword(name, email, password);
  }

  signOut() {
    return authService.signout();
  }
}
