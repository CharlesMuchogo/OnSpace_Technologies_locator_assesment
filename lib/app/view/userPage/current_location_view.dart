import 'package:flutter/material.dart';
import 'package:locator/app/domain/models/user/user.dart';
import 'package:locator/app/utils/Utils.dart';
import 'package:locator/app/utils/locator_custom_cliper.dart';

class CurrentLocationView extends StatelessWidget {
  const CurrentLocationView({required this.user, super.key});
  final User user;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: LocatorCustomCliper(),
      child: Container(
        height: 150,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
            bottom: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Now is',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
                Text(
                  user.location.placeName,
                  style:
                  Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.location_on_outlined),
                Text(
                  'Since ${epochMillisecondsToTime(user.location.lastUpdate)}',
                  style:
                  Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
                Text(
                  '${minutesDifference(user.location.lastUpdate)}'
                      ' min updated',
                  style:
                  Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
