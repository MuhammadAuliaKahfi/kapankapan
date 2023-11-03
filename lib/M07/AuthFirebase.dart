import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future SignUp(String email, String password) async {
    UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    User? user = authResult.user;
    return user?.uid;
  }

  Future Login(String email, String password) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = authResult.user;
      return user?.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getUser() async {
    User? user = await _firebaseAuth.currentUser;
    return user;
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  Future googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (err) {
      print(err.message);
      return null;
    }
  }
}
