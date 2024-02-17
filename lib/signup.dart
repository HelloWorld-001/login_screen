// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_screen/auth_methods.dart';
import 'package:login_screen/input_box.dart';
import 'package:login_screen/landing_page.dart';
import 'package:login_screen/verification_page.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final nameController = TextEditingController().obs;

  final emailController = TextEditingController().obs;

  final passwordController = TextEditingController().obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 25),
          InputBox(
            controller: nameController.value,
            textInputType: TextInputType.text,
            hintText: "Name",
            prefixIcon: Icons.person_rounded,
          ),
          SizedBox(height: 20),
          InputBox(
            controller: emailController.value,
            textInputType: TextInputType.emailAddress,
            hintText: "Email",
            prefixIcon: Icons.email_rounded,
          ),
          SizedBox(height: 20),
          InputBox(
            controller: passwordController.value,
            textInputType: TextInputType.text,
            hintText: "Password",
            prefixIcon: Icons.password,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => signUp(context),
            style: ButtonStyle(
              fixedSize: MaterialStatePropertyAll(Size(double.maxFinite, 50)),
              backgroundColor: MaterialStatePropertyAll(Colors.black),
              overlayColor: MaterialStatePropertyAll(Colors.grey.shade700),
              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10))
            ),
            child: Text(
              "SignUp",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.maxFinite, height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Container(color: Colors.grey.shade400, height: 1)),
                SizedBox(width: 10),
                Text(
                  "OR",
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade400, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Expanded(child: Container(color: Colors.grey.shade400, height: 1)),
              ],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              Map<String, String> googleSignInResult = await AuthMethods().googleSignIn();
              if(googleSignInResult.entries.first.key != "err") {
                Get.to(() => LandingPage());
              }
            },
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              backgroundColor: MaterialStatePropertyAll(Colors.black),
              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 5)),
              overlayColor: MaterialStatePropertyAll(Colors.grey.shade700)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40, height: 40,
                  child: Image.asset("assets/images/google.png", scale: 0.1)
                ),
                SizedBox(width: 10),
                Text(
                  "Sign Up with Google",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void signUp(context) async {
    String registerResult = await AuthMethods().registerUserWithEmail(
      email: emailController.value.text,
      password: passwordController.value.text
    );
    if(registerResult != 'success') {
      return;
    }
    Get.to(
      () => VerificationPage(
        email: emailController.value.text,
        name: nameController.value.text
      )
    );
  }
}
