import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onigiri/models/index.dart' as Models;

class Auth {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _userRef = _db.collection('user');

  static Future<void> _checkUserInDB() async {
    User user = getUser();
    DocumentSnapshot snapshot = await _userRef.doc(user.uid).get();
    if (snapshot.data() == null) {
      print("New user detected. Pushing new user to db ...");
      _pushUserToDB(user);
    }
  }

  static void _pushUserToDB(User user) {
    Models.User newUser = Models.User(
      id: user.uid,
      displayName: user.displayName,
      email: user.email,
      photoUrl: user.photoURL,
    );
    _userRef.doc(newUser.id).set(newUser.toMap(withId: false));
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

  static Future<User> googleSignIn() async {
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
