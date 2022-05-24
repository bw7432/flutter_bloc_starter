import 'package:flutter/material.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  navigateToAndRemove(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, ModalRoute.withName(routeName));
  }

  goBack() {
    return navigatorKey.currentState!.pop();
  }
}
