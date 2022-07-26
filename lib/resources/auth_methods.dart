import 'dart:typed_data'; // for Uint8List

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'storage_methods.dart';
import 'package:instagram_clone/models/user.dart'
    as model; // avoid clash with User from firebase

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    // make reference to collection named 'users'
    // get() here returns a document snapShot (1-time read like an actual snapShot)
    DocumentSnapshot snap = await _firestore
        .collection('users')
        .doc(currentUser.uid)
        .get(); // cant be null since logged in

    return model.User.fromSnap(snap);
  }

  /*
  Handles user sign-up process
  */
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username, // stored in firestore database
    required String bio, // stored in firestore database
    required Uint8List
        file, // a fixed-length list of 8-bit unsigned integers, for user image
  }) async {
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

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        // add user to our database
        await _firestore
            .collection('users') // add to collection 'users'
            // create one if it doesn't alr exist
            .doc(cred.user!.uid) // ! exclamation mark bcuz user can be null
            // ! makes sure the doc name and uid are the same
            // if the uid already exists, then it will overwrite the existing data
            .set(
              user.toJson(),
            );
        res = "success";
      }
    } catch (err) {
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

  /*
  Handles user login process
  */
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Error logging in!";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Login successful";
      } else {
        res = "Email & Password field required!";
      }
    } catch (err) {
      // similarly, can customise msg with on FirebaseAuthException
      res = err.toString();
    }
    return res;
  }
}
