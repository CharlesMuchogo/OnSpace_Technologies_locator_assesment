import 'package:flutter/material.dart';
import 'package:locator/app/domain/models/user/user.dart';
import 'package:locator/app/utils/locator_custom_cliper.dart';
import 'package:locator/app/view/components/add_icon.dart';
import 'package:locator/app/view/home/user_card.dart';

class UsersView extends StatelessWidget {
  const UsersView({required this.users, super.key});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddIcon(
                label: 'Add new tag',
              ),
              AddIcon(
                label: 'Add new item',
              ),
            ],
          ),
          ClipPath(
            clipper: LocatorCustomCliper(),
            child: Container(
              height: size.height * 0.35,
              width: size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                  bottom: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilterChip(
                          selected: true,
                          selectedColor: Colors.lime.shade600,
                          label: const Text('All'),
                          onSelected: null,
                        ),
                        FilterChip(
                          selected: true,
                          selectedColor: Colors.lime.shade600,
                          label: const Text('people'),
                          onSelected: null,
                        ),
                        FilterChip(
                          selected: true,
                          selectedColor: Colors.lime.shade600,
                          label: const Text('items'),
                          onSelected: null,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return UserCard(
                          user: users[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
