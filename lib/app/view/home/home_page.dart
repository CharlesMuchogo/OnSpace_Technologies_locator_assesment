import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locator/app/domain/cubits/users/users_cubit.dart';
import 'package:locator/app/domain/models/user/user.dart';
import 'package:locator/app/view/components/bottom_nav_item.dart';
import 'package:locator/app/view/components/icon_button.dart';
import 'package:locator/app/view/home/google_map_page.dart';
import 'package:locator/app/view/home/users_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];

  Set<Marker> markers = {};
  int pageIndex = 0;

  String searchParameter = '';
  bool showSearchBar = false;

  final pages = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UsersCubit>(context).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is LoadingUsersState && users.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorGettingUsersState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<UsersCubit>(context).getUsers();
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ),
                  ),
                  const Text('Error getting users'),
                ],
              ),
            );
          }

          if (state is LoadedUsersState) {
            users = state.data;
            markers = users.map((e) {
              return Marker(
                markerId: MarkerId(e.name),
                infoWindow: InfoWindow(
                  title: e.name,
                  snippet: e.name,
                ),
                position: LatLng(
                  e.location.latitude,
                  e.location.longitude,
                ),
                draggable: true,
                onDragEnd: (value) {},
              );
            }).toSet();

            if (searchParameter != '') {
              users = users
                  .where((element) =>
                      element.name
                          .toLowerCase()
                          .contains(searchParameter.toLowerCase()) ||
                      element.location.placeName
                          .toLowerCase()
                          .contains(searchParameter.toLowerCase()) ||
                      element.type
                          .toLowerCase()
                          .contains(searchParameter.toLowerCase()))
                  .toList();
            } else {
              users = users;
            }
          }

          return SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                MapPage(markers: markers),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: showSearchBar
                      ? appBarSearch()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: CircleAvatarWithIcon(
                                icon: Icons.search,
                                backgroundColor: Colors.white,
                                iconColor: Colors.black,
                                onPressed: () {
                                  setState(() {
                                    showSearchBar = true;
                                  });
                                },
                                radius: 30,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: const CircleAvatarWithIcon(
                                icon: Icons.settings,
                                backgroundColor: Colors.white,
                                iconColor: Colors.black,
                                radius: 30,
                              ),
                            )

                          ],
                        ),
                ),

                Positioned(
                  bottom: 0,
                  left: 8,
                  right: 8,
                  child: Column(
                    children: [
                      UsersView(
                        users: users,
                      ),
                      customNavBar(context)
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget appBarSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40,
          padding: const EdgeInsets.only(left: 10),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              keyboardType: TextInputType.text,

              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: const Icon(Icons.search),
                hintText: '  Search user',
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
                hintStyle: TextStyle(color: Colors.grey.shade600),
              ),
              style: const TextStyle(color: Colors.black),
              //controller: password,

              onChanged: (value) {
                setState(() {
                  searchParameter = value;
                });
              },
              onSaved: (val) {
                searchParameter = val!;
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CircleAvatarWithIcon(
            paddingValues: 5,
            icon: Icons.close,
            backgroundColor: Colors.white,
            iconColor: Colors.black,
            onPressed: () {
              setState(() {
                showSearchBar = false;
              });
            },
            radius: 20,
          ),
        ),
      ],
    );
  }

  Widget customNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      child: Container(
        height: 70,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
              selected: pageIndex == 0,
              onTap: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              selectedIcon: Icons.home,
              unSelectedIcon: Icons.home_outlined,
              label: 'Home',
            ),
            BottomNavItem(
              selected: pageIndex == 1,
              onTap: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              selectedIcon: Icons.route,
              unSelectedIcon: Icons.route_outlined,
              label: 'Driving',
            ),
            BottomNavItem(
              selected: pageIndex == 2,
              onTap: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              selectedIcon: Icons.safety_check,
              unSelectedIcon: Icons.safety_check_outlined,
              label: 'Safety',
            ),
            BottomNavItem(
              selected: pageIndex == 3,
              onTap: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              selectedIcon: Icons.chat_bubble,
              unSelectedIcon: Icons.chat_bubble_outline,
              label: 'Chat',
            ),
          ],
        ),
      ),
    );
  }
}
