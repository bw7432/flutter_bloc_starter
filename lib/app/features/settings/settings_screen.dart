import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter/app/features/settings/index.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    required SettingsBloc settingsBloc,
    Key? key,
  })  : _settingsBloc = settingsBloc,
        super(key: key);

  final SettingsBloc _settingsBloc;

  @override
  SettingsScreenState createState() {
    return SettingsScreenState();
  }
}

class SettingsScreenState extends State<SettingsScreen> {
  SettingsScreenState();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  logout() {
    widget._settingsBloc.add(LogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: widget._settingsBloc,
        listener: (BuildContext context, state) {
          if (state is RedirectState) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', ModalRoute.withName('/login'));
          }
        },
        child: BlocBuilder<SettingsBloc, SettingsState>(
            bloc: widget._settingsBloc,
            builder: (
              BuildContext context,
              SettingsState currentState,
            ) {
              if (currentState is UnSettingsState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (currentState is ErrorSettingsState) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(currentState.errorMessage),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: ElevatedButton(
                        child: Text('reload'),
                        onPressed: _load,
                      ),
                    ),
                  ],
                ));
              }
              if (currentState is InSettingsState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(currentState.hello),
                      const Text('Flutter files: done'),
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: ElevatedButton(
                          child: Text('Logout'),
                          onPressed: () => logout(),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  void _load([bool isError = false]) {
    widget._settingsBloc.add(LoadSettingsEvent(isError));
  }
}
