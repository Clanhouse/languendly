import 'package:flutter/material.dart';
import 'package:frontend/screens/screens.dart';
import 'utilities.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return HomeScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(Strings.error()),
        ),
        body: Center(
          child: Text(Strings.something_went_wrong()),
        ),
      ),
    );
  }
}
