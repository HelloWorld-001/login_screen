import 'package:firebase_auth/firebase_auth.dart';
import 'users.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // * : Register User
  Future<String> registeruser({
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
}