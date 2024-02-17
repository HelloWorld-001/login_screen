// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_screen/auth_methods.dart';
import 'package:login_screen/input_box.dart';
import 'package:login_screen/landing_page.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25),
            InputBox(
              controller: emailController.value,
              textInputType: TextInputType.emailAddress,
              hintText: "Email",
              prefixIcon: Icons.mail_rounded,
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
              onPressed: logIn,
              style: ButtonStyle(
                fixedSize: MaterialStatePropertyAll(Size(double.maxFinite, 50)),
                backgroundColor: MaterialStatePropertyAll(Colors.black),
                overlayColor: MaterialStatePropertyAll(Colors.grey.shade700),
                padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10))
              ),
              child: Text(
                "Login",
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
                } else {
                  print(googleSignInResult);
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
                    "Log In with Google",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void logIn() async {
    String signInResult = await AuthMethods().loginUser(email: emailController.value.text, password: passwordController.value.text);
    if(signInResult == "success") {
      Get.to(() => LandingPage());
    } else {
      print(signInResult);
    }
  }
}
