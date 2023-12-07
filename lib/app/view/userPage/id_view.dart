import 'package:flutter/material.dart';
import 'package:locator/app/domain/models/user/user.dart';
import 'package:locator/app/view/components/icon_button.dart';

class IdView extends StatelessWidget {
  const IdView({required this.user, super.key});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
          bottom: Radius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          const Icon(Icons.info_outline),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
                bottom: Radius.circular(15),
              ),
            ),
            child: Text(
              'id${user.id}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Icon(Icons.message_outlined),
        ],
      ),
    );

  }
}
