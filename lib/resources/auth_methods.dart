import 'dart:typed_data'; // for Uint8List
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // method to sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username, // stored in firestore database
    required String bio, // stored in firestore database
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
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        // add user to our database
        await _firestore
            .collection('users') // add to collection 'users'
            // create one if it doesn't alr exist
            .doc(cred.user!.uid) // ! exclamation mark bcuz user can be null
            .set({
          // if the uid already exists, then it will overwrite the existing data
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
        });
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
