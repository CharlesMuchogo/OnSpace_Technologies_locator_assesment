import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locator/app/domain/models/user/user.dart';
import 'package:locator/app/utils/locator_custom_cliper.dart';
import 'package:locator/app/view/components/add_icon.dart';
import 'package:locator/app/view/home/user_card.dart';

class UsersView extends StatefulWidget {
  UsersView({required this.users, super.key});

  List<User> users;

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  String filterUsers = 'all';

  List<String> filterItems = ['All','Items', 'People' ];


  List<User> get filteredUsers {
    if (filterUsers.toLowerCase() == 'all') {
      return widget.users;
    } else {
      return widget.users
          .where((element) {
            return element.type.toLowerCase() == filterUsers.toLowerCase();})
          .toList();
    }
  }

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
                      children: filterItems.map((String filterItem) {
                        return FilterChip(
                          selected: filterUsers == filterItem,
                          selectedColor: Colors.lime.shade600,
                          label: Text(filterItem),
                          onSelected: (bool selected) {
                            setState(() {
                              filterUsers = filterItem;
                              log(filterUsers);
                            });
                          },
                        );
                      }).toList(),
                    ),

                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        return UserCard(
                          user: filteredUsers[index],
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
