import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:locator/app/data/mock_repository_impl.dart';
import 'package:locator/app/domain/cubits/updates/get_updates_cubit.dart';
import 'package:locator/app/domain/models/location/location.dart';

void main() {
  late GetUpdatesCubit updatesCubit;
  late MockRepositoryImpl mockRepositoryImpl;
  late List<Location> fakeUpdates;
  setUp(() {
    mockRepositoryImpl = MockRepositoryImpl();
    updatesCubit = GetUpdatesCubit(repository: mockRepositoryImpl);
    fakeUpdates = mockRepositoryImpl.updates
        .map(
          Location.fromJson,
        )
        .toList();
  });

  blocTest<GetUpdatesCubit, GetUserUpdatesState>(
    'Test if user updates are fetched properly',
    build: () => updatesCubit,
    act: (bloc) async {
      await bloc.getUserUpdates(id: 1);
      await Future<void>.delayed(const Duration(seconds: 5));
    },
    expect: () => [
      LoadingUserUpdatesState(),
      LoadedUserUpdatesState(fakeUpdates),
    ],
  );
}
