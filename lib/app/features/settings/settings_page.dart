import 'package:flutter/material.dart';
import 'package:flutter_starter/app/features/settings/index.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _settingsBloc = SettingsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsScreen(settingsBloc: _settingsBloc),
    );
  }
}
