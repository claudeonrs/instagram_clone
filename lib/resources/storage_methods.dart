import 'package:flutter/material.dart';
import 'dart:typed_data'; // for Uint8List
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // add image to firebase storage
  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    bool isPost, // is it a post or profile picture?
  ) async {
    // pointer to file in storage (ref)
    // Storage --> profilePic folder (child of storage)  -->
    //         --> uid folder containing profile pic of the same user (child of profilePic)
    Reference ref = _storage
        .ref() // returns a Reference object, default is root folder
        .child(childName)
        .child(_auth.currentUser!.uid); // path to put pic in

    // put image file into user's uid folder
    UploadTask uploadTask = ref.putData(file);

    // need to wait until upload is finished
    TaskSnapshot snap = await uploadTask;

    // get image download url to be stored as user's attribute in Firestore Database
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
