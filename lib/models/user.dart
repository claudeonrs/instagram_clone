import 'package:cloud_firestore/cloud_firestore.dart';

/*
Class contains details/data required of a User to be stored in firebase
*/
class User {
  final String email;
  final String uid;
  final String username;
  final String bio;
  final List followers;
  final List following;
  final String photoUrl;

  const User({
    required this.email,
    required this.uid,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
    required this.photoUrl,
  });

  /*
  whenever this method is called, converts & write all the data to an object file
  */
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };

  /*
  Get the data/value/text/display for the corresponding section
  */
  static User fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapShot['username'],
      uid: snapShot['uid'],
      email: snapShot['email'],
      photoUrl: snapShot['photoUrl'],
      bio: snapShot['bio'],
      followers: snapShot['followers'],
      following: snapShot['following'],
    );
  }
}
