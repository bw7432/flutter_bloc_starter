import 'package:flutter/material.dart';
import 'package:flutter_starter/app/features/home/index.dart';
import 'package:flutter_starter/app/features/settings/index.dart';

class AppState extends ChangeNotifier {
  int _friendRequestCount = 0;

  int get friendRequestCount => _friendRequestCount;

  void setFriendRequestCount(value) {
    _friendRequestCount = value ?? 0;
    notifyListeners();
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  get widgetOptions => _widgetOptions;

  final List<Widget> _widgetOptions = [HomePage(), SettingsPage()];

  setSelectedIndex(value) {
    _selectedIndex = value;
    notifyListeners();
  }
}
