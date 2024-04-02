import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/model/user_model.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  signUpWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final UserModel userData =
          UserModel(name: name, email: email, uid: userCredential.user?.uid);
      firestore
          .collection('user')
          .doc(userCredential.user?.uid)
          .set(userData.toJson());
      return userCredential.user;
    } catch (e) {
      print('some error');
    }
  }

  signInWithEmailAndPassword(String email, String password, context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      firestore.collection('user').doc(userCredential.user!.uid).set(
          {'uid': userCredential.user!.uid, 'email': email},
          SetOptions(merge: true));
      return userCredential.user;
    } on FirebaseException catch (e) {
      String errorcode = 'error signIn';
      if (e.code == 'wrong-paswword' || e.code == 'user-not-found') {
        errorcode = "Incorrect email and password";
      } else if (e.code == 'user-disabled') {
        errorcode = 'User Not Found';
      } else {
        errorcode = e.code;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorcode)));
    }
  }

  
  signout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print('This is the erro r$e');
    }
  }
}
