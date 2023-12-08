import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locator/app/data/repository.dart';
import 'package:locator/app/data/repository_impl.dart';
import 'package:locator/app/domain/cubits/updates/updates_cubit.dart';
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
    var screenSize = MediaQuery.of(context).size;
    BlocProvider.of<UpdatesCubit>(context).getUserUpdates(id: user.id);
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
            icon: Icons.send_rounded,
            backgroundColor: Colors.black,
            iconColor: Colors.white,
            radius: 18,
            rotateIcon: true,
          ),
        ],
        centerTitle: true,
        leading: CircleAvatarWithIcon(
          paddingValues: 10,
          icon: Icons.arrow_back_ios,
          backgroundColor: Colors.white,
          onPressed: () => Navigator.pop(context),
          iconColor: Colors.black,
          radius: 15,
        ),
      ),
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
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

              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatarWithIcon(
                        paddingValues: 10,
                        icon: Icons.call_outlined,
                        backgroundColor: Colors.black,
                        iconColor: Colors.white,
                        radius: 25,
                      ),
                      Container(
                        width: 200,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                            bottom: Radius.circular(30),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Follow',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,),
                          ),
                        ),
                      ),
                      const CircleAvatarWithIcon(
                        paddingValues: 10,
                        icon: Icons.battery_5_bar_outlined,
                        backgroundColor: Colors.black,
                        iconColor: Colors.white,
                        radius: 25,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget columnSpacer({double height = 15}) {
    return SizedBox(
      height: height,
    );
  }
}
