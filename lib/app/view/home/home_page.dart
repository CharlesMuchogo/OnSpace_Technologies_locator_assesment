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
              return  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                      BlocProvider.of<UsersCubit>(context).getUsers();
                    }, icon:const Icon(Icons.refresh, color: Colors.black,),),
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
            }

            return SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  MapPage(markers: markers),
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatarWithIcon(
                          paddingValues: 10,
                          icon: Icons.search,
                          backgroundColor: Colors.white,
                          iconColor: Colors.black,
                          radius: 30,
                        ),
                        CircleAvatarWithIcon(
                          paddingValues: 10,
                          icon: Icons.settings,
                          backgroundColor: Colors.white,
                          iconColor: Colors.black,
                          radius: 30,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 8,
                    right: 8,
                    child: Column(
                      children: [
                        UsersView(users: users,),
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

    Widget customNavBar(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
              bottom: Radius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              BottomNavItem(
                selected:pageIndex == 0,
                onTap: (){
                  setState(() {
                    pageIndex = 0;
                  });
                },
                selectedIcon: Icons.home,
                unSelectedIcon: Icons.home_outlined,
                label: 'Home',
              ),

                BottomNavItem(
                selected:pageIndex == 1,
                onTap: (){
                  setState(() {
                    pageIndex = 1;
                  });
                },
                selectedIcon: Icons.route,
                unSelectedIcon: Icons.route_outlined,
                label: 'Driving',
              ),

               BottomNavItem(
                selected:pageIndex == 2,
                onTap: (){
                  setState(() {
                    pageIndex = 2;
                  });
                },
                selectedIcon: Icons.safety_check,
                unSelectedIcon: Icons.safety_check_outlined,
                label: 'Safety',
              ),

              BottomNavItem(
                selected:pageIndex == 3,
                onTap: (){
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
