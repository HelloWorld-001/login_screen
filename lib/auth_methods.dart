import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'users.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // * : Register User
  Future<String> registerUserWithEmail({
    required String email,
    required String password
  }) async {
    String res = "Some error occured";

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email, password: password
      );
      res = "success";
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // * : SignUp User
  Future<String> signUpUser({
    required String name,
    required String email,
  }) async {
    String res = "Some error occured";
    String uid = _auth.currentUser!.uid;

    model.User user = model.User(
      uid: uid,
      name: name,
      email: email
    );

    try {
      await FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .set(user.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // * : Google SignIn
  Future<Map<String, String>> googleSignIn() async {
    Map<String, String> res = {
      "start" : "start"
    };

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCred = await FirebaseAuth.instance.signInWithCredential(credential);
      res = {
        "name" : userCred.user!.displayName.toString(),
        "email" : userCred.user!.email.toString()
      };
      return res;
    } catch (err) {
      res = {
        "err" : err.toString()
      };
    }
    return res;
  }
}