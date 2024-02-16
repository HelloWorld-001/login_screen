// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/auth_methods.dart';
import 'package:login_screen/background_page.dart';
import 'package:login_screen/landing_page.dart';
import 'package:lottie/lottie.dart';

class VerificationPage extends StatefulWidget {
  final String name;
  final String email;
  const VerificationPage({super.key, required this.name, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User user;

  late Timer timer;
  bool isVerified = false;
  bool isResendButtonEnabled = false;
  int timerSeconds = 90;
  bool isSignedUp = false;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        checkEmailVerified();
      },
    );

    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: media.height, width: media.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            BackgroundPage(),
            SizedBox(
              height: media.height - media.width/2, width: media.width/1.15,
              child: Card(
                elevation: 1,
                shadowColor: Colors.white.withOpacity(0.7),
                color: Color(0xFFFBF9F1).withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.email_outlined, color: Color(0xFFD64135), size: 90),
                      Text(
                        "Please verify your email", textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF47545D), fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "You are almost there! We sent an email to ",
                              style: TextStyle(color: Color(0xFF494D56), fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: widget.email,
                              style: TextStyle(color: Color(0xFF494D56), fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                          ],
                        )
                      ),
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Just click on the link to complete your signup. If you dont't se it, you may need to ",
                              style: TextStyle(color: Color(0xFF494D56), fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: "check your spam ",
                              style: TextStyle(color: Color(0xFF494D56), fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                              text: "folder.",
                              style: TextStyle(color: Color(0xFF494D56), fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                      ),
                      Column(
                        children: [
                          Lottie.asset(
                            (isVerified) ? "assets/lottie_json/pandaWithHeadphones.json" : "assets/lottie_json/musicLoader.json",
                            width: 100, height: 100
                          ),
                          SizedBox(height: 10),
                          Text(
                            (isVerified) ? "Verified Successfully \u2713" : "Verifying.....",
                            style: TextStyle(color: (isVerified) ? Color(0xFF7E30E1) : Color(0xFF494D56), fontSize: 20, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      if(!isVerified)
                        Column(
                          children: [
                            Text(
                              "Still can't find the email? No problem", textAlign: TextAlign.center,
                              style: TextStyle(color: Color(0xFF494D56), fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            ElevatedButton(
                              onPressed: (!isResendButtonEnabled)
                              ? null
                              : () {
                                setState(() {
                                  isResendButtonEnabled = false;
                                  timerSeconds = 90;
                                });
                                startTimer();
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  (isResendButtonEnabled) ? Color(0xFF7E30E1) : Colors.transparent
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                                ),
                                side: MaterialStatePropertyAll(
                                  BorderSide(color: Color(0xFF7E30E1), width: 2)
                                ),
                                overlayColor: MaterialStatePropertyAll(Colors.grey.withOpacity(0.2))
                              ),
                              child: Text(
                                (isResendButtonEnabled)
                                ? "Resend Verification Link"
                                : "Resend Verification Link in ${timerSeconds}s",
                                style: TextStyle(color: (!isResendButtonEnabled) ? Color(0xFF7E30E1) : Colors.white, fontSize: 18),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Change email address!",
                                style: TextStyle(color: Color(0xFF7E30E1), fontSize: 16, decoration: TextDecoration.underline, decorationColor: Color(0xFF7E30E1)),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();

    if(user.emailVerified) {
      setState(() => isVerified = true);
      String signUpResult = await AuthMethods().signUpUser(
        name: widget.name,
        email: widget.email
      );
      if(signUpResult != 'success') {
        user.delete();
      } else {
        setState(() => isSignedUp = true);
        if(mounted) {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LandingPage();
            },
          ),
        );
        }
      }
    }
  }

  void startTimer() {
    timerSeconds = 90;
    Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if(timerSeconds == 0) {
          setState(() => isResendButtonEnabled = true);
          timer.cancel();
        } else {
          setState(() => timerSeconds--);
        }
      },
    );
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}