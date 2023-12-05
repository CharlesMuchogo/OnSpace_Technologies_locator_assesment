import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locator/app/data/repository.dart';
import 'package:locator/app/data/repository_impl.dart';
import 'package:locator/app/domain/models/user.dart';
import 'package:locator/counter/cubit/get_users_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Repository repository = RepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetUsersCubit(repository: repository),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  HomeView({super.key});

  List<User> users = [];
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetUsersCubit>(context).getUsers();

    return Scaffold(
      body: BlocBuilder<GetUsersCubit, GetUsersState>(
        builder: (context, state) {
          if(state is LoadingUsersState){
            return const Center(child: CircularProgressIndicator(),);
          }else if (state is ErrorGettingUsersState){
            return const Center(child: Text('Error getting user data'),);
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
                  e.location.longitude,
                  e.location.latitude,
                ),
                draggable: true,
                onDragEnd: (value) {},
              );
            }).toSet();
          }

          return Center(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target:  LatLng(-1.2655367, 36.8104826),
                zoom: 10,
              ),
              markers: Set<Marker>.of(markers),
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {},
            ),
          );
        },
      ),
    );
  }
}
