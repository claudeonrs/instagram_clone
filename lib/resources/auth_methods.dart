import 'dart:typed_data'; // for Uint8List

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // method to sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username, // stored in firestore database
    required String bio, // stored in firestore database
    required Uint8List
        file, // a fixed-length list of 8-bit unsigned integers, for user image
  }) async {
    print('f');
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid); // WHAT IS THIS FOR???

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // add user to our database
        await _firestore
            .collection('users') // add to collection 'users'
            // create one if it doesn't alr exist
            .doc(cred.user!.uid) // ! exclamation mark bcuz user can be null
            // ! makes sure the doc name and uid are the same
            .set({
          // if the uid already exists, then it will overwrite the existing data
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });
        res = "success";
      }
    } catch (err) {
      print("Something died!");
      res = err.toString();
    }
    // if wish to customise error message from firebase,
    // on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email') {
    //     res = 'The email is wrongly formatted.';
    //   }
    // }
    return res;
  }
}
