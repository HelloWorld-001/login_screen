// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';

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
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    double outerRadius = 60;
    double innerRadius = 0;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover)
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: media.height, width: media.width,
                margin: EdgeInsets.symmetric(horizontal: media.width/10, vertical: media.height/7),
                child: ClipPath(
                  clipper: MyClipper(
                    innerRadius: innerRadius, outerRadius: outerRadius,
                    size: Size(media.width/1.25, media.height/1.4)
                  ),
                  child: Card(
                    elevation: 2,
                    shadowColor: Colors.white.withOpacity(0.9),
                    color: Colors.white.withOpacity(0.8),
                    child: SignUpForm(),
                  ),
                ),
              ),
              Positioned(
                top: media.height/10 - 25,
                child: CircleAvatar(
                  radius: outerRadius - innerRadius, backgroundColor: Colors.black.withOpacity(0.5),
                  child: Icon(Icons.headphones, color: Colors.white, size: 75),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  double outerRadius = 0;
  double innerRadius = 0;
  Size size = Size(0, 0);
  MyClipper({required this.outerRadius, required this.innerRadius, required this.size});
  @override
  Path getClip(Size size) {
    size = this.size;
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width/2 + outerRadius, 0);
    path.arcTo(Rect.fromCircle(center: Offset(size.width/2 - innerRadius, 0), radius: outerRadius), 0, pi, false);
    path.lineTo(size.width/2 - outerRadius, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


class SignUpForm extends StatelessWidget {
  SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TF()
        ],
      ),
    );
  }
}

class TF extends StatelessWidget {
  const TF({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}