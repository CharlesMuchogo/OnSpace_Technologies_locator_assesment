import 'package:flutter/material.dart';

class CircleAvatarWithIcon extends StatelessWidget {
  const CircleAvatarWithIcon({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.radius,
    super.key,
    this.onPressed, this.rotateIcon = false,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double radius;
  final VoidCallback? onPressed;
  final bool rotateIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        radius: radius,
        child: Transform.rotate(
          angle: rotateIcon ? - (50 * 3.14159265359 / 180) : 0,
          child: Icon(
            icon,
            color: iconColor,
            size: radius * 0.9,
          ),
        ),
      ),
    );
  }
}
