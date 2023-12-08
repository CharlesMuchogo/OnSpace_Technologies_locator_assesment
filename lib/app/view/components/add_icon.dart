import 'package:flutter/material.dart';
import 'package:locator/app/view/components/icon_button.dart';

class AddIcon extends StatelessWidget {
  const AddIcon({required this.label, super.key, this.onPressed});

  final String label;
  final VoidCallback? onPressed;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration:  BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
            bottom: Radius.circular(30),

          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatarWithIcon(
                icon: Icons.add,
                backgroundColor: Theme.of(context).primaryColor,
                iconColor: Colors.black,
                radius: 18,
              ),
              const SizedBox(width: 15,),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}
