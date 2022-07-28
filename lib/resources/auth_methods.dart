import 'dart:typed_data'; // for Uint8List
<<<<<<< Updated upstream
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
=======

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'storage_methods.dart';
>>>>>>> Stashed changes

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // method to sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username, // stored in firestore database
    required String bio, // stored in firestore database
<<<<<<< Updated upstream
    // required Uint8List file, // a fixed-length list of 8-bit unsigned integers
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              bio.isNotEmpty //||
          //file != null
          ) {
=======
    required Uint8List // a fixed-length list of 8-bit unsigned integers,
        file, // * for user image
  }) async {
    print('f');
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
>>>>>>> Stashed changes
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

<<<<<<< Updated upstream
=======
        // ! PROBLEMATIC
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

>>>>>>> Stashed changes
        // add user to our database
        await _firestore
            .collection('users') // add to collection 'users'
            // create one if it doesn't alr exist
            .doc(cred.user!.uid) // ! exclamation mark bcuz user can be null
<<<<<<< Updated upstream
=======
            // ! makes sure the doc name and uid are the same
>>>>>>> Stashed changes
            .set({
          // if the uid already exists, then it will overwrite the existing data
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
<<<<<<< Updated upstream
        });
        res = "success";
=======
          'photoUrl': photoUrl,
        });
        res = "success";
      } else {
        res = "Please enter all the fields";
>>>>>>> Stashed changes
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
