import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/save_article_model.dart';

class SaveArticleFireController {


  final CollectionReference saveArticleCollection = FirebaseFirestore.instance.collection('saveArticles');

  Future<void> saveArticle(SaveArticleModel saveArticle, String userID) async {

    try {
      await saveArticleCollection.doc().set(saveArticle.toJson());
      Get.snackbar(
          'Saved!', 'This Article Successfully Saved',
          icon: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.done,
              size: 30,
              color: Colors.lightGreen,
            ),
          ),
          colorText: Colors.white,
          backgroundColor: Colors.blue
      );
    } catch (e) {
      if (kDebugMode) {
        print('Failed to save article: $e');
      }
    }
  }

  Future<void> fetchSaveArticleData() async {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {

      final saveArticleDoc = FirebaseFirestore.instance.collection('saveArticles').doc(user.uid);

      // Fetch data from Firestore and update text controllers
      final saveArticleData = await saveArticleDoc.get();
      final data = saveArticleData.data();

    }
  }
}