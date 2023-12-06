import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locator/app/domain/cubits/updates/get_updates_cubit.dart';
import 'package:locator/app/domain/models/location/location.dart';
import 'package:locator/app/utils/Utils.dart';

class UpdatesView extends StatelessWidget {
   UpdatesView({super.key});
  List<Location> updates = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Last Updates',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<GetUpdatesCubit, GetUserUpdatesState>(
            builder: (context, state) {
              if (state is LoadingUserUpdatesState) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ErrorGettingUserUpdatesState) {
                return const Expanded(
                  child: Center(
                    child: Text('Error getting user Location updates'),
                  ),
                );
              }

              if (state is LoadedUserUpdatesState) {
                updates = state.updates;
              }

              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: updates.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(updates[index].placeName),
                          Text(
                            epochMillisecondsToTime(
                              updates[index].lastUpdate,
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
