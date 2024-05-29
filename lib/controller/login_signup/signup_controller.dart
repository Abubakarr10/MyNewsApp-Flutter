import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_news_app/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/user_model.dart';
import '../../respository/auth_service_repo.dart';
import '../../view/login_signup/login_screen.dart';
import '../share_preferences/share_preferences_controller.dart';
import '../userFire/user_fire_controller.dart';

class SignupController extends GetxController{

  RxBool loading = false.obs;
  RxBool passwordIsVisible = true.obs;
  RxBool isChecked = false.obs;

  final authService = AuthService();
  late SharedPreferences prefs;

  void initSharedPrefs() async{
    prefs = await SharedPreferences.getInstance();
  }

  UserFireController userFireController = UserFireController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  void signUp(var formKey)async{
    if (formKey) {
      try {

        loading.value = true;

        final user = await authService.createUserWithEmailAndPassword(
            emailController.text.toString().trim(),
            passwordController.text.toString().trim()
        );

        if (user != null) {
          final currentUser = user;

          UserModel userModel = UserModel(
              uid: currentUser.uid,
              email: emailController.text.toString().trim(),
              fullName: fullNameController.text.toString().trim(),
              password: passwordController.text.toString().trim(),
          );

          userFireController.createUser(userModel);

          Get.snackbar(
            'Yahoo!', 'Account Created Successfully',
            icon: const Padding(
              padding: EdgeInsets.only(right: 10),
            ),
            backgroundColor: Colors.blueAccent
          );


          Get.to(()=> const LoginScreen());

        }
      } on FirebaseAuthException catch (error) {

        Get.snackbar(
            'OOPS!', 'Something Went Wrong ${error.toString}',
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
    } else {
      Get.snackbar(
        'OOPS!', 'Something Wrong',
        icon: const Icon(
          Icons.error,
          size: 30,
          color: Colors.white,
        ),
      );

    }
  }

  Future<void> signUpWithGoogle() async {

    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

    try {
      // Sign out from any previously signed-in accounts
      await googleSignIn.signOut();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in process
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCollection = FirebaseFirestore.instance.collection('users');

      // Fetch user information from GoogleSignInAccount
      final name = googleUser.displayName ?? ''; // Use display name from Google
      final email = googleUser.email;

      final querySnapshot = await userCollection.where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        Get.snackbar(
            'Please Login!', 'This Email Already Exists',
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
      }


      // Create a new Firebase user with Google credentials
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      String userId = userCredential.user!.uid;

      // Get the new user's ID
      final currentUser = userCredential.user;
      // Update user's display name
      await currentUser!.updateDisplayName(name);

      // Store user data in Firestore
      UserModel userModel = UserModel(
          uid: currentUser.uid,
          email: email,
          fullName: name, password: '',
      );

      userFireController.createUser(userModel);

      // prefs.setString('email', email);
      // await saveLoginStatus(true);

      Get.off(()=> const HomeScreen());

    } catch (error) {
      if (error is FirebaseAuthException) {
        if (error.code == 'user-canceled') {
          // User canceled the sign-in process
          Get.snackbar(
              'OOPS!', 'SignIn Process Canceled.',
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
        } else {
          Get.snackbar(
              'An Error Occurred', error.message.toString(),
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
        }
      } else {
        // Handle other non-Firebase exceptions (e.g., no internet)
        Get.snackbar(
            'An ERROR', '$error.',
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
      }
    }
  }

}