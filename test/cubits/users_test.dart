import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:locator/app/data/mock_repository_impl.dart';
import 'package:locator/app/domain/cubits/users/users_cubit.dart';
import 'package:locator/app/domain/models/user/user.dart';

void main() {
  group('GetUsersCubit Tests', () {
    late UsersCubit usersCubit;
    late MockRepositoryImpl mockRepositoryImpl;
    late List<User> fakeUsers;
    setUp(() {
      mockRepositoryImpl = MockRepositoryImpl();
      usersCubit = UsersCubit(repository: mockRepositoryImpl);
      fakeUsers = mockRepositoryImpl.users
          .map(
        User.fromJson,
      )
          .toList();
    });

    blocTest<UsersCubit, UsersState>(
      'Test if users are fetched properly',
      build: () => usersCubit,
      act: (bloc) async {
        await bloc.getUsers();
        await Future<void>.delayed(const Duration(seconds: 5));
      },
      expect: () => [
        LoadingUsersState(),
        LoadedUsersState(data: fakeUsers),
      ],
    );
  });

  // group('GetUsersCubit Failure Tests', () {
  //   late GetUsersCubit usersCubit;
  //   late MockRepositoryImpl mockRepositoryImpl;
  //   late String? errorResponse;
  //
  //   setUp(() {
  //     mockRepositoryImpl = MockRepositoryImpl(testFailure: true);
  //     usersCubit = GetUsersCubit(repository: mockRepositoryImpl);
  //     errorResponse = mockRepositoryImpl.errorResponse['message'];
  //   });
  //
  //   blocTest<GetUsersCubit, GetUsersState>(
  //     'Test if get users failure is handled correctly',
  //     build: () => usersCubit,
  //     act: (bloc) async {
  //       await bloc.getUsers();
  //       await Future<void>.delayed(const Duration(seconds: 5));
  //     },
  //     expect: () => [
  //       LoadingUsersState(),
  //       ErrorGettingUsersState(error: errorResponse.toString()),
  //     ],
  //   );
  // });
}
