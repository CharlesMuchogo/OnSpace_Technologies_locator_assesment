import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem(
      {required this.unSelectedIcon,
      required this.selectedIcon,
      required this.label,
      required this.onTap,
      required this.selected,
      super.key});

  final IconData unSelectedIcon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          enableFeedback: false,
          onPressed: onTap,
          icon: selected
              ? Icon(
                  selectedIcon,
                  color: Colors.black,
                  size: 25,
                )
              : Icon(
                  unSelectedIcon,
                  color: Colors.black,
                  size: 25,
                ),
        ),
        Text(
          label,
          style: TextStyle(
              fontWeight: selected ? FontWeight.bold : FontWeight.normal),
        )
      ],
    );
  }
}
