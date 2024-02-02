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

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
                  clipper: CardClipper(
                    innerRadius: innerRadius, outerRadius: outerRadius,
                    size: Size(media.width/1.25, media.height/1.4)
                  ),
                  child: Card(
                    elevation: 2,
                    shadowColor: Colors.white.withOpacity(0.9),
                    color: Colors.white.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 75),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Signup",
                            style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 15),
                          TF(
                            controller: usernameController,
                            textInputType: TextInputType.name,
                            hintText: "Username",
                            prefixIcon: Icons.person,
                          ),
                          SizedBox(height: 20),
                          TF(
                            controller: passwordController,
                            textInputType: TextInputType.text,
                            hintText: "Email",
                            prefixIcon: Icons.email_rounded,
                          ),
                          SizedBox(height: 20),
                          TF(
                            controller: passwordController,
                            textInputType: TextInputType.text,
                            hintText: "Password",
                            prefixIcon: Icons.password,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              fixedSize: MaterialStatePropertyAll(Size(double.maxFinite, 50)),
                              backgroundColor: MaterialStatePropertyAll(Colors.black),
                              overlayColor: MaterialStatePropertyAll(Colors.grey.shade700),
                              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10))
                            ),
                            child: Text(
                              "SignUp",
                              style: TextStyle(color: Colors.lightGreenAccent, fontSize: 25),
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
                            onPressed: () {},
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
                    ),
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


class TF extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType textInputType;
  const TF({super.key, required this.controller, required this.hintText, required this.prefixIcon, required this.textInputType});

  @override
  State<TF> createState() => _TFState();
}

class _TFState extends State<TF> {
  bool pass = false;
  bool showPass = false;

  @override
  void initState() {
    super.initState();
    if(widget.hintText == "Password") {
      setState(() {
        pass = true;
      });
    }
  }

  void changeVisibility() {
    setState(() {
      showPass = (showPass == true) ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.deepPurple, width: 2)
    );
    return TextField(
      controller: widget.controller,
      obscureText: showPass,
      keyboardType: widget.textInputType,
      style: TextStyle(color: Colors.black, fontSize: 20),
      decoration: InputDecoration(
        border: border,
        enabledBorder: border,
        hintText: "",
        labelStyle: TextStyle(color: Colors.grey.shade800),
        alignLabelWithHint: true,
        labelText: widget.hintText,
        prefixIcon: Icon(widget.prefixIcon, color: Colors.deepPurple, size: 20),
        suffixIcon: (widget.hintText != "Password")
        ? null
        : IconButton(onPressed: changeVisibility, icon: Icon((showPass) ? Icons.visibility : Icons.visibility_off, color: Colors.grey)),
      ),
    );
  }
}