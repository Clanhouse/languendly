import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/bloc/auth/auth_bloc.dart';
import 'package:frontend/repositories/repositories.dart';
import 'package:frontend/screens/sign_in/sign_in_screen.dart';
import 'package:frontend/screens/splash/splash_screen.dart';
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

  EquatableConfig.stringify = true;
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
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AuthRepository>(
                create: (_) => AuthRepository(),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider<DarkModeCubit>(
                  create: (context) => DarkModeCubit(),
                ),
                BlocProvider<AuthBloc>(
                  create: (context) => AuthBloc(
                    authRepository: context.read<AuthRepository>(),
                  ),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                builder: BotToastInit(),
                navigatorObservers: [BotToastNavigatorObserver()],
                locale: context.locale,
                title: Strings.languendly(),
                theme: ThemeData(
                  fontFamily: 'Georgia',
                  appBarTheme: AppBarTheme(color: Color.fromRGBO(0, 103, 163, 1)),
                  primaryColor: Color.fromRGBO(0, 103, 163, 1),
                  scaffoldBackgroundColor: Color.fromRGBO(0, 121, 191, 1),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 103, 163, 1)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                  cardColor: Colors.grey[200],
                ),
                darkTheme: ThemeData(
                  fontFamily: 'Georgia',
                  brightness: Brightness.dark,
                ),
                themeMode: state ? ThemeMode.dark : ThemeMode.light,
                onGenerateRoute: CustomRouter.onGenerateRoute,
                initialRoute: SplashScreen.routeName,
              ),
            ),
          );
        },
      ),
    );
  }
}
