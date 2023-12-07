import 'package:flutter/material.dart';

class LocatorCustomCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width / 2, size.height / 9, size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - size.height / 9)
      ..quadraticBezierTo(size.width / 2, size.height - size.height / 6, 0,
          size.height - size.height / 9,)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
