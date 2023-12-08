import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locator/app/data/mock_repository_impl.dart';
import 'package:locator/app/data/repository.dart';
import 'package:locator/app/data/repository_impl.dart';
import 'package:locator/app/domain/cubits/updates/updates_cubit.dart';
import 'package:locator/app/domain/cubits/users/users_cubit.dart';
import 'package:locator/app/view/home/home_page.dart';
import 'package:locator/l10n/l10n.dart';

class App extends StatelessWidget {
  App({super.key});

  final Repository repository = RepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UsersCubit(repository: repository),
        ),
        BlocProvider(
          create: (context) => UpdatesCubit(repository: repository),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(primaryColor: Colors.lime),
        home: HomePage(),
      ),
    );
  }
}
