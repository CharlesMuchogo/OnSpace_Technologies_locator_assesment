import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:locator/app/data/repository.dart';
import 'package:locator/app/domain/models/location/location.dart';

part 'updates_state.dart';

class UpdatesCubit extends Cubit<UpdatesState> {
  UpdatesCubit({required this.repository}) : super(InitialUserUpdatesState());
  final Repository repository;

  Future<void> getUserUpdates({required int id}) async {
    emit(LoadingUserUpdatesState());
    try {
      final response = await repository.getUserUpdates(id: id);

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);

        final users = (userData as List)
            .map(
              (userJson) => Location.fromJson(userJson as Map<String, dynamic>),
            )
            .toList();
        emit(LoadedUserUpdatesState(users));
      } else {
        final dynamic errorData = jsonDecode(response.body);
        emit(ErrorGettingUserUpdatesState(errorData['message'].toString()));
      }
    } catch (e) {
      log('error is -> $e');
      emit(ErrorGettingUserUpdatesState(e.toString()));
    }
  }
}
