import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:locator/app/data/repository.dart';
import 'package:locator/app/domain/models/user/user.dart';
import 'package:equatable/equatable.dart';


part 'get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  GetUsersCubit({required this.repository}) : super(InitialUsersState());
  final Repository repository;

  Future<void> getUsers() async {
    emit(LoadingUsersState());
    try {
      final response = await repository.getUsers();

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);

        final users = (userData as List)
            .map(
              (userJson) => User.fromJson(userJson as Map<String, dynamic>),
            )
            .toList();
        emit(LoadedUsersState(data: users));
      } else {
        final dynamic errorData = jsonDecode(response.body);
        emit(ErrorGettingUsersState(errorData['message'].toString()));
      }
    } catch (e) {
      log('error is -> $e');
      emit(ErrorGettingUsersState(e.toString()));
    }
  }
}
