part of 'updates_cubit.dart';

abstract class UpdatesState extends Equatable {
 const UpdatesState();
}


class InitialUserUpdatesState extends UpdatesState {
  @override
  List<Object?> get props => [];
}

class LoadingUserUpdatesState extends UpdatesState {
  @override
  List<Object?> get props => [];
}

class LoadedUserUpdatesState extends UpdatesState {
  const LoadedUserUpdatesState(this.updates);
  final List<Location> updates;

  @override
  List<Object?> get props => [updates];
}

class ErrorGettingUserUpdatesState extends UpdatesState {
  const ErrorGettingUserUpdatesState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
