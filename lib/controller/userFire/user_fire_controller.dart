import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../model/user_model.dart';

class UserFireController{

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');


  Future<void> createUser(UserModel user) async {
    try {
      await userCollection.doc(user.uid).set(user.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Failed to create user: $e');
      }
    }
  }

  Future<UserModel?> getUserData(String uid) async {
    try {
      final userDataDoc = await userCollection.doc(uid).get();
      if (userDataDoc.exists) {
        UserModel userModel = UserModel.fromJson(userDataDoc.data() as Map<String, dynamic>);
        return userModel;
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching user data: $error');
      }
    }
    return null; // Return an empty map if data is not found or an error occurs.
  }
}