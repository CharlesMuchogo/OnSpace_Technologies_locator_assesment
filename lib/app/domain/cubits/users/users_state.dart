
part of 'users_cubit.dart';


abstract class UsersState extends Equatable{
  const UsersState();
}


class InitialUsersState extends UsersState {
  @override
  List<Object?> get props => [];
}

class LoadingUsersState extends UsersState {
  @override
  List<Object?> get props => [];
}

class LoadedUsersState extends UsersState with EquatableMixin {
  LoadedUsersState({required this.data});
  final List<User> data;

  @override
  List<Object?> get props => [data];
}

class ErrorGettingUsersState extends UsersState {
  const ErrorGettingUsersState({required this.error});
  final String error;
  @override
  List<Object?> get props => [error];
}
