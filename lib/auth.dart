import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseDatabase _db = FirebaseDatabase.instance;

  static void checkState(context, {redirect}) {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        final path = redirect ?? '/login';
        print("User is not signed in, redirecting to $path ...");
        Navigator.pushReplacementNamed(context, path);
      }
    });
  }

  static void _checkUserInDB() {
    DatabaseReference _userRef = _db.reference().child('user');
    User currentUser = getUser();
    _userRef.child(currentUser.uid).once().then((snapshot) {
      if (snapshot.value == null) {
        print("New user detected. Pushing new user to db ...");
        _pushUserToDB(currentUser);
      }
    });
  }

  static void _pushUserToDB(user) {
    DatabaseReference _userRef = _db.reference().child('user');
    DatabaseReference _pushRef = _userRef.child(user.uid);
    _pushRef.set({
      'display_name': user.displayName,
      'email': user.email,
      'photo_url': user.photoUrl,
    });
  }

  static User getUser() {
    return _auth.currentUser;
  }

  static bool isSignedIn() {
    return (getUser() != null);
  }

  static Stream<User> authState() {
    return _auth.authStateChanges();
  }

  static googleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final User user = (await _auth.signInWithCredential(credential)).user;
    print("Signed in user: ${user.displayName} (${user.uid})");

    _checkUserInDB();

    return user;
  }

  static Future<void> signOut() {
    return _auth.signOut();
  }
}
