// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

class BackgroundPage extends StatelessWidget {
  BackgroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    var safeArea = MediaQuery.of(context).padding;
    return SizedBox(
      height: media.height, width: media.width,
      child: ClipPath(
        clipper: BackgroundClipper(safeArea),
        child: Card(
          elevation: 2,
          shadowColor: Colors.white.withOpacity(0.9),
          color: Colors.white.withOpacity(0.8),
          child: Container(
            height: media.height, width: media.width, color: Color(0xff0D9276),
          )
        ),
      ),
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