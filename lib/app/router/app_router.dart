import 'package:flutter/material.dart';
import 'package:flutter_starter/app/features/home/index.dart';
import 'package:flutter_starter/app/features/settings/index.dart';

class MainRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case '/settings':
        return MaterialPageRoute(
          builder: (_) => SettingsPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
    }
  }
}
