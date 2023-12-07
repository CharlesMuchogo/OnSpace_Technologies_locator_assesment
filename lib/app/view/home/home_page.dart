import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locator/app/domain/cubits/users/get_users_cubit.dart';
import 'package:locator/app/domain/models/user/user.dart';
import 'package:locator/app/utils/locator_custom_cliper.dart';
import 'package:locator/app/view/components/add_icon.dart';
import 'package:locator/app/view/components/icon_button.dart';
import 'package:locator/app/view/userPage/user_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<User> users = [];
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetUsersCubit>(context).getUsers();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<GetUsersCubit, GetUsersState>(
        builder: (context, state) {
          if (state is LoadingUsersState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorGettingUsersState) {
            return const Center(
              child: Text('Error getting user data'),
            );
          }

          if (state is LoadedUsersState) {
            users = state.data;
            markers = users.map((e) {
              return Marker(
                // icon: BitmapDescriptor.fromBytes(),
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
                GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(-1.2655367, 36.8104826),
                    zoom: 17,
                  ),
                  markers: Set<Marker>.of(markers),
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {},
                ),
                Positioned(
                  bottom: 0,
                  left: 8,
                  right: 8,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SingleChildScrollView(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        FilterChip(
                                            selected: true,
                                            selectedColor: Colors.lime.shade600,
                                            label: const Text('All'),
                                            onSelected: null),
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
                                            onSelected: null),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: users.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserPage(user: users[index]),
                                            ),
                                          );
                                        },
                                        leading: SizedBox(
                                          width: 50,
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: CachedNetworkImage(
                                              imageUrl: users[index].imageLink,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      CircleAvatar(
                                                radius: 30,
                                                backgroundImage: imageProvider,
                                              ),
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive(),
                                              ),
                                              errorWidget: (context, url, error) =>
                                                  const Center(
                                                child: Icon(
                                                  Icons.image,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          users[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        subtitle:
                                            Text(users[index].location.placeName),
                                        trailing: const CircleAvatarWithIcon(
                                          icon: Icons.send_rounded,
                                          backgroundColor: Colors.black,
                                          iconColor: Colors.white,
                                          rotateIcon: true,
                                          radius: 18,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
