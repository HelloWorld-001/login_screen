// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_screen/auth_methods.dart';
import 'package:login_screen/input_box.dart';
import 'package:login_screen/landing_page.dart';
import 'package:login_screen/verification_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 25),
          InputBox(
            controller: nameController,
            textInputType: TextInputType.text,
            hintText: "Name",
            prefixIcon: Icons.person_rounded,
          ),
          SizedBox(height: 20),
          InputBox(
            controller: emailController,
            textInputType: TextInputType.emailAddress,
            hintText: "Email",
            prefixIcon: Icons.email_rounded,
          ),
          SizedBox(height: 20),
          InputBox(
            controller: passwordController,
            textInputType: TextInputType.text,
            hintText: "Password",
            prefixIcon: Icons.password,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => performFunction(context),
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
                if(mounted) {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LandingPage(),
                  )
                );
                }
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

  void performFunction(context) async {
    String registerResult = await AuthMethods().registerUserWithEmail(
      email: emailController.text,
      password: passwordController.text
    );
    if(registerResult != 'success') {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationPage(email: emailController.text, name: nameController.text)
      )
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
