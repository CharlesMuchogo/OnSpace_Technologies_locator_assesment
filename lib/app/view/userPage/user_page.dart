import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locator/app/data/repository.dart';
import 'package:locator/app/data/repository_impl.dart';
import 'package:locator/app/domain/cubits/updates/get_updates_cubit.dart';
import 'package:locator/app/domain/models/user/user.dart';
import 'package:locator/app/utils/Utils.dart';
import 'package:locator/app/view/userPage/current_location_view.dart';
import 'package:locator/app/view/userPage/updates_view.dart';

import 'id_view.dart';

class UserPage extends StatelessWidget {
  UserPage({required this.user, super.key});

  final User user;
  final Repository repository = RepositoryImpl();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetUpdatesCubit>(context).getUserUpdates(id: user.id);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text(
          user.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send_sharp),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 180,
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: user.imageLink,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 180,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.image,
                      size: 100,
                    ),
                  ),
                ),
              ),
            ),
            IdView(user: user),
            CurrentLocationView(user: user),
            UpdatesView(),
          ],
        ),
      ),
    );
  }
}
