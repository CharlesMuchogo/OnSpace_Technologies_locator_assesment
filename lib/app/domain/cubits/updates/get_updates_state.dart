part of 'get_updates_cubit.dart';

abstract class GetUserUpdatesState extends Equatable {
 const GetUserUpdatesState();
}


class InitialUserUpdatesState extends GetUserUpdatesState {
  @override
  List<Object?> get props => [];
}

class LoadingUserUpdatesState extends GetUserUpdatesState {
  @override
  List<Object?> get props => [];
}

class LoadedUserUpdatesState extends GetUserUpdatesState {
  const LoadedUserUpdatesState(this.updates);
  final List<Location> updates;

  @override
  List<Object?> get props => [updates];
}

class ErrorGettingUserUpdatesState extends GetUserUpdatesState {
  const ErrorGettingUserUpdatesState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
