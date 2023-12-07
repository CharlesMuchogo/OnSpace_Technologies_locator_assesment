import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locator/app/data/repository.dart';
import 'package:locator/app/data/repository_impl.dart';
import 'package:locator/app/domain/cubits/updates/get_updates_cubit.dart';
import 'package:locator/app/domain/models/user/user.dart';
import 'package:locator/app/view/components/icon_button.dart';
import 'package:locator/app/view/userPage/current_location_view.dart';
import 'package:locator/app/view/userPage/id_view.dart';
import 'package:locator/app/view/userPage/updates_view.dart';

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
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        title: Text(
          user.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: const [

           CircleAvatarWithIcon(
             paddingValues: 10,
             icon:Icons.send_rounded,
            backgroundColor: Colors.black,
            iconColor: Colors.white,
            radius: 18,
             rotateIcon: true,
          ),
        ],
        centerTitle: true,
        leading:

        CircleAvatarWithIcon(
          paddingValues: 10,
          icon: Icons.arrow_back_ios,
          backgroundColor: Colors.white,
          onPressed: () => Navigator.pop(context),
          iconColor: Colors.black,
          radius: 15,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: SingleChildScrollView(
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
              columnSpacer(),
              IdView(user: user),
              columnSpacer(),
              CurrentLocationView(user: user),
              columnSpacer(),
              UpdatesView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget columnSpacer ({double height = 15}){
    return SizedBox(height: height,);

  }
}
