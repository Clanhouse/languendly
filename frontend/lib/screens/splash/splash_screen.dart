import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/bloc/bloc.dart';
import 'package:frontend/screens/screens.dart';
import 'package:frontend/utilities/utilities.dart';
import 'package:frontend/widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/spalsh';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (prevState, state) => prevState.status != state.status,
            listener: (context, state) {
              if (state.status == EAuthStatus.authenticated) {
                Navigator.of(context).pushNamedAndRemoveUntil(SplashScreen.routeName, (_) => false);
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              }

              if (state.status == EAuthStatus.unauthenticated) {
                Navigator.of(context).pushNamedAndRemoveUntil(SplashScreen.routeName, (_) => false);
                Navigator.of(context).pushNamed(SignInScreen.routeName);
              }
            },
          ),
        ],
        child: const Scaffold(
          body: Center(
            child: CustomLoadingWidget(),
          ),
        ),
      ),
    );
  }
}
