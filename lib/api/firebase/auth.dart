import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onigiri/api/firebase/db/user.dart';
import 'package:onigiri/models/index.dart' as Models;

class Auth {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> _checkUserInDB() async {
    User firebaseUser = getFirebaseUser();
    Models.User user = await UserAPI.get(firebaseUser.uid);
    if (user == null) {
      print("New user detected. Pushing new user to db ...");
      await _pushUserToDB(firebaseUser);
    }
  }

  static Future<void> _pushUserToDB(User firebaseUser) {
    Models.User newUser = Models.User(
      id: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      email: firebaseUser.email,
      photoUrl: firebaseUser.photoURL,
    );
    return UserAPI.set(newUser);
  }

  static User getFirebaseUser() {
    return _auth.currentUser;
  }

  static bool isSignedIn() {
    return (getFirebaseUser() != null);
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

    final User firebaseUser =
        (await _auth.signInWithCredential(credential)).user;
    print("Signed in user: ${firebaseUser.displayName} (${firebaseUser.uid})");

    await _checkUserInDB();

    return firebaseUser;
  }

  static Future<void> signOut() {
    return _auth.signOut();
  }
}
