// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_screen/auth_methods.dart';
import 'package:login_screen/main.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final User user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String googleRes = await AuthMethods().googleSignOut();
            await FirebaseAuth.instance.signOut();
            Get.offAll(() => SignUpLoginPage());
          },
          child: Text("Logout")
        ),
      ),
    );
  }
}