// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables
// +33, +64
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BackgroundPage extends StatelessWidget {
  BackgroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    var safeArea = MediaQuery.of(context).padding;
    return Stack(
      children: [
        ClipPath(
          clipper: BackgroundClipper(safeArea),
          child: Card(
            elevation: 2,
            shadowColor: Colors.white.withOpacity(0.9),
            color: Colors.white.withOpacity(0.8),
            child: Container(
              height: media.height, width: media.width, color: Color(0xff7E30E1),
            )
          ),
        ),
        Positioned(
          top: 0, left: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Lottie.asset(
                "assets/lottie_json/disk1.json",
                animate: true, alignment: Alignment.bottomCenter, fit: BoxFit.cover, width: 120, height: 120
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: Lottie.asset(
            "assets/lottie_json/notes1.json",
            animate: true, alignment: Alignment.bottomLeft, fit: BoxFit.fitWidth, width: media.width, height: media.height
          ),
        ),
        Positioned(
          bottom: 0,
          child: SafeArea(
            child: Lottie.asset(
              "assets/lottie_json/musicRhythm.json",
              animate: true, width: media.width, alignment: Alignment.bottomCenter, fit: BoxFit.cover
            ),
          )
        ),
      ],
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  EdgeInsets safeArea = EdgeInsets.all(0);
  BackgroundClipper(this.safeArea);
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width / 2 , 0);
    path.arcTo(
      Rect.fromCircle(
        center: Offset(0, 0),
        radius: size.width/2 + safeArea.top
      ), 0, 0.5 * pi, false
    );
    path.moveTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height - size.width/4);
    path.quadraticBezierTo(
      size.width/1.15, size.height/1.15, size.width, size.height/3
    );
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}