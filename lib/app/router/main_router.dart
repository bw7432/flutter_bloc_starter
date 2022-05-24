import 'package:flutter/material.dart';
import 'package:flutter_starter/app.dart';
import 'package:flutter_starter/app/features/login/index.dart';
import 'package:flutter_starter/app/features/sign_up/index.dart';
import 'package:flutter_starter/landing.dart';

class MainRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const Landing(),
        );
      case '/app':
        return MaterialPageRoute(
          builder: (_) => const App(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case '/sign_up':
        return MaterialPageRoute(
          builder: (_) => SignUpPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Landing(),
        );
    }
  }
}
