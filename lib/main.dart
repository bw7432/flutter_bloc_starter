import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/app/router/main_router.dart';
import 'package:flutter_starter/app/services/navigator_service.dart';
import 'package:flutter_starter/locator.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final MainRouter _mainRouter = MainRouter();

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        bottomAppBarColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.black45),
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white60),
      ),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        navigatorObservers: [
          // locator<FirebaseAnalyticsService>().getAnalyticsObserver()
        ],
        onGenerateRoute: _mainRouter.onGenerateRoute,
        navigatorKey: locator<NavigatorService>().navigatorKey,
      ),
    );
  }
}
