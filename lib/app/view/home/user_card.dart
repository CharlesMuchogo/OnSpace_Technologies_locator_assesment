import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:locator/app/domain/models/user/user.dart';
import 'package:locator/app/view/components/icon_button.dart';
import 'package:locator/app/view/userPage/user_page.dart';

class UserCard extends StatelessWidget {
  const UserCard({required this.user, super.key});
  final User user;

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                UserPage(user: user),
          ),
        );
      },
      leading: SizedBox(
        width: 50,
        child: AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: user.imageLink,
            imageBuilder: (context, imageProvider) =>
                CircleAvatar(
                  radius: 30,
                  backgroundImage: imageProvider,
                ),
            placeholder: (context, url) =>
            const Center(
              child: CircularProgressIndicator.adaptive(),
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
        user.name,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(user.location.placeName),
      trailing: const CircleAvatarWithIcon(
        icon: Icons.send_rounded,
        backgroundColor: Colors.black,
        iconColor: Colors.white,
        rotateIcon: true,
        radius: 18,
      ),
    );
  }
}
