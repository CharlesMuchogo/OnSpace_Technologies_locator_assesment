part of 'get_users_cubit.dart';

abstract class GetUsersState {
  const GetUsersState();
}


class InitialUsersState extends GetUsersState {}

class LoadingUsersState extends GetUsersState {}

class LoadedUsersState extends GetUsersState {
  LoadedUsersState(this.data);
  final List<User> data;
}

class ErrorGettingUsersState extends GetUsersState {
  ErrorGettingUsersState(this.error);
  final String error;
}
