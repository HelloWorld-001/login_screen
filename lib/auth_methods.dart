import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'users.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // * : Register User
  Future<String> registerUser({
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
      print("Register user error: $err");
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
}