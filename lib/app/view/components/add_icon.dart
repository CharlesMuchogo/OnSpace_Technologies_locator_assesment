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
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
            bottom: Radius.circular(25),
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
              const SizedBox(width: 20,),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}
