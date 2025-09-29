import 'package:flutter/material.dart';

class InwardCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);

    // خمیدگی به سمت داخل
    path.quadraticBezierTo(
      size.width / 2, size.height - 50, // وسط بالاتر
      size.width, size.height,          // سمت راست پایین
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
