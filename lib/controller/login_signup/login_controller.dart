import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_news_app/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../respository/auth_service_repo.dart';
import '../share_preferences/share_preferences_controller.dart';

class LoginController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool loading = false.obs;
  RxBool passwordIsVisible = true.obs;

  final _auth = FirebaseAuth.instance;

  final authService = AuthService();
  late SharedPreferences prefs;

  void initSharedPrefs() async{
    prefs = await SharedPreferences.getInstance();
  }


  void login(var formKey)async{

    final user = await authService.loginUserWithEmailAndPassword(
        emailController.text.toString(),
        passwordController.text.toString()
    );

    if(formKey){
      try{

        loading.value = true;

        if(user != null) {

          // prefs.setString('email', emailController.value.text.toString());
          // await saveLoginStatus(true);

          Get.off(() => const HomeScreen());

        } else {
          Get.snackbar(
              'OOPS!', 'Something Went Wrong',
              icon: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.error,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              colorText: Colors.white,
              backgroundColor: Colors.red
          );
          loading.value = false;
        }

      } on FirebaseAuthException catch(error){
        Get.snackbar(
            'OOPS!', 'Something Wrong. $error',
            icon: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.error,
                size: 50,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red
        );

        loading.value = false;

      }
    }

  }

  Future<void> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;

      final String email = googleUser.email.toLowerCase();

      final QuerySnapshot<
          Map<String, dynamic>> userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userQuery.size > 0) {

        // User registered with Google, proceed with login
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential authResult = await _auth.signInWithCredential(credential);
        final User? currentUser = authResult.user;

        // prefs.setString('email', email);
        // await saveLoginStatus(true);
        if (currentUser != null) {
          Get.off(() => const HomeScreen());
        }

      } else {
        Get.snackbar(
          'Email Does Not Exist!', 'Please register first yourself.',
          icon: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.error,
              size: 50,
              color: Colors.blue,
            ),
          ),
        );
      }
    } catch (error) {
      Get.snackbar(
        'OOPS!', error.toString(),
        icon: const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.error,
            size: 50,
            color: Colors.blue,
          ),
        ),
      );
    }
  }


}