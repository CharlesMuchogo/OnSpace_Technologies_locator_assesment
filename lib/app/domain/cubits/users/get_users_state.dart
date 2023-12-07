
part of 'get_users_cubit.dart';


abstract class GetUsersState extends Equatable{
  const GetUsersState();
}


class InitialUsersState extends GetUsersState {
  @override
  List<Object?> get props => [];
}

class LoadingUsersState extends GetUsersState {
  @override
  List<Object?> get props => [];
}

class LoadedUsersState extends GetUsersState with EquatableMixin {
  LoadedUsersState({required this.data});
  final List<User> data;

  @override
  List<Object?> get props => [data];
}

class ErrorGettingUsersState extends GetUsersState {
  const ErrorGettingUsersState({required this.error});
  final String error;
  @override
  List<Object?> get props => [error];
}
