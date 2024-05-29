import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService{

  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email,String password) async{
    try{
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (error){
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email,String password) async{
    try{
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (error){
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return null;
  }

  Future<void> logout()async{
    try{
      await _auth.signOut();
    }catch(error){
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

}