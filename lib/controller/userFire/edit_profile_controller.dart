import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController{

  final fullNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final user = FirebaseAuth.instance.currentUser.obs;

  Future<void> fetchUserData() async {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the user's document in Firestore
      final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Fetch data from Firestore and update text controllers
      final userData = await userDoc.get();
      final data = userData.data(); // Retrieve all fields and values as a Map

      if (data != null) {

        fullNameController.value.text = data['fullName'] ?? '';
        emailController.value.text = data['email'] ?? '';
        passwordController.value.text = data['password'] ?? '';

      }
    }
  }


  Future<void> updateUserData() async {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Reference to the user's document in Firestore
        final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

        // Update the fields in Firestore with the values from the text controllers
        await userDoc.update({
          'fullName': fullNameController.value.text,
          'email': emailController.value.text,
          'password': passwordController.value.text,
        });


        // Show a success message or navigate to another screen if needed
        Get.snackbar(
          'Done!', 'Successfully Updated',
          icon: const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.done_sharp,
              size: 30,
              color: Colors.lightGreen,
            ),
          ),
          backgroundColor: Colors.blue,
            colorText: Colors.white
        );
      } catch (error) {
        // Handle any errors that occur during the update
        Get.snackbar(
            'OOPS!', 'Something went wrong! $error',
            icon: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.error,
                size: 50,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
            colorText: Colors.white
        );
      }
    }
  }
}

