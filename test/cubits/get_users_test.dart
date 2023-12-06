import 'dart:ffi';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:locator/app/data/mock_repository_impl.dart';
import 'package:locator/app/domain/cubits/users/get_users_cubit.dart';
import 'package:locator/app/domain/models/user/user.dart';

void main() {
  late GetUsersCubit usersCubit;
  late MockRepositoryImpl mockRepositoryImpl;
  late List<User> fakeUsers;
  setUp(() {
    mockRepositoryImpl = MockRepositoryImpl();
    usersCubit = GetUsersCubit(repository: mockRepositoryImpl);
    fakeUsers = mockRepositoryImpl.users
        .map(
          User.fromJson,
        )
        .toList();
  });

  blocTest<GetUsersCubit, GetUsersState>(
    'Test if users are fetched properly',
    build: () => usersCubit,
    act: (bloc) async {
      bloc.getUsers();
      await Future<void>.delayed(const Duration(seconds: 5));
    },
    expect: () => [
      LoadingUsersState(),
      LoadedUsersState(data: fakeUsers),
    ],
  );
}
