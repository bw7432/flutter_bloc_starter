import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter_starter/app/features/settings/index.dart';
import 'package:flutter_starter/app/repository/user_repository.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SettingsEvent {
  Stream<SettingsState> applyAsync(
      {SettingsState currentState, SettingsBloc bloc});
  final UserRepository _userRepository = UserRepository();
}

class UnSettingsEvent extends SettingsEvent {
  @override
  Stream<SettingsState> applyAsync(
      {SettingsState? currentState, SettingsBloc? bloc}) async* {
    yield UnSettingsState(0);
  }
}

class LoadSettingsEvent extends SettingsEvent {
  final bool isError;
  @override
  String toString() => 'LoadSettingsEvent';

  LoadSettingsEvent(this.isError);

  @override
  Stream<SettingsState> applyAsync(
      {SettingsState? currentState, SettingsBloc? bloc}) async* {
    try {
      yield UnSettingsState(0);
      await Future.delayed(const Duration(seconds: 1));
      yield InSettingsState(0, 'Hello world');
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadSettingsEvent', error: _, stackTrace: stackTrace);
      yield ErrorSettingsState(0, _.toString());
    }
  }
}

class LogoutEvent extends SettingsEvent {
  // final bool isError;
  @override
  String toString() => 'LoadSettingsEvent';

  LogoutEvent();

  @override
  Stream<SettingsState> applyAsync(
      {SettingsState? currentState, SettingsBloc? bloc}) async* {
    try {
      await _userRepository.signOut();
      yield RedirectState(0);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadSettingsEvent', error: _, stackTrace: stackTrace);
      yield ErrorSettingsState(0, _.toString());
    }
  }
}
