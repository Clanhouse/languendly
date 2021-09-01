import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/utilities/utilities.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:path_provider/path_provider.dart';

import 'package:frontend/screens/screens.dart';
import 'bloc/bloc.dart';
import 'cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  EquatableConfig.stringify = false;
  setPathUrlStrategy();
  Bloc.observer = SimpleBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );
  runApp(EasyLocalization(
      supportedLocales: [
        Locale('pl'),
        Locale('en'),
      ],
      path: 'resources/languages.csv',
      saveLocale: true,
      useOnlyLangCode: true,
      assetLoader: CsvAssetLoader(),
      fallbackLocale: Locale('pl'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DarkModeCubit>(
          create: (context) => DarkModeCubit(),
        ),
      ],
      child: BlocBuilder<DarkModeCubit, bool>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: Constants.languendly(),
            theme: ThemeData(
              fontFamily: 'Georgia',
              primarySwatch: Colors.indigo,
            ),
            darkTheme: ThemeData(
              fontFamily: 'Georgia',
              brightness: Brightness.dark,
            ),
            themeMode: state ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: CustomRouter.onGenerateRoute,
            initialRoute: HomeScreen.routeName,
          );
        },
      ),
    );
  }
}
