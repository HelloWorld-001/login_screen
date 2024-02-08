// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:login_screen/background_page.dart';
import 'package:login_screen/login.dart';
import 'package:login_screen/signup.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black
      ),
      home: Stack(
        alignment: Alignment.center,
        children: [
          BackgroundPage(),
          SignUpLoginPage(),
        ],
      ),
    );
  }
}

class SignUpLoginPage extends StatefulWidget {
  SignUpLoginPage({super.key});

  @override
  State<SignUpLoginPage> createState() => _SignUpLoginPageState();
}

class _SignUpLoginPageState extends State<SignUpLoginPage> {
  bool login = true;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    double outerRadius = 60;
    double innerRadius = 0;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.transparent,
                height: media.height/1.4, width: media.width,
                margin: EdgeInsets.symmetric(horizontal: media.width/10, vertical: media.height/8),
                child: ClipPath(
                  clipper: CardClipper(
                    innerRadius: innerRadius, outerRadius: outerRadius,
                    size: Size(media.width/1.25, media.height/1.4)
                  ),
                  child: Card(
                    elevation: 0,
                    shadowColor: Colors.white.withOpacity(0.8),
                    color: Color(0xFFFBF9F1).withOpacity(0.8),
                    child: Container(
                      height: double.maxFinite, width: double.maxFinite,
                      constraints: BoxConstraints(maxHeight: double.maxFinite),
                      padding: const EdgeInsets.only(top: 80),
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        resizeToAvoidBottomInset: false,
                        body: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () => setState(() => login = true),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: (login) ? Color(0xFF7E30E1) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Color(0xFF7E30E1), width: 3)
                                    ),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(color: (login) ? Colors.white : Color(0xFF7E30E1), fontWeight: FontWeight.bold, fontSize: 30),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(() => login = false),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: (!login) ? Color(0xFF7E30E1) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Color(0xFF7E30E1), width: 3)
                                    ),
                                    child: Text(
                                      "SignUp",
                                      style: TextStyle(color: (!login) ? Colors.white : Color(0xFF7E30E1), fontWeight: FontWeight.bold, fontSize: 30),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            (login) ? LogIn() : SignUp()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: media.height/12.5,
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(255,212,38, 1),
                  radius: outerRadius - 10,
                  child: Lottie.asset(
                    "assets/lottie_json/pandaWithHeadphones.json",
                    animate: true,
                    width: 150, height: 150
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class CardClipper extends CustomClipper<Path> {
  double outerRadius = 0;
  double innerRadius = 0;
  Size size = Size(0, 0);
  CardClipper({required this.outerRadius, required this.innerRadius, required this.size});
  @override
  Path getClip(Size size) {
    size = this.size;
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width/2 + outerRadius, 0);
    path.arcTo(Rect.fromCircle(center: Offset(size.width/2 - innerRadius, 10), radius: outerRadius), 0, pi, false);
    path.lineTo(size.width/2 - outerRadius, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}