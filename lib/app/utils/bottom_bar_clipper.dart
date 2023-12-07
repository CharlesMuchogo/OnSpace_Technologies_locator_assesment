import 'package:flutter/material.dart';

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const double curveHeight = 20;

    path..moveTo(0, 0)
    ..lineTo(0, size.height - curveHeight)
    ..quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - curveHeight)
    ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}