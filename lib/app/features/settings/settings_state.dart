import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  SettingsState(this.version);

  /// notify change state without deep clone state
  final int version;

  /// Copy object for use in action
  /// if need use deep clone
  SettingsState getStateCopy();

  SettingsState getNewVersion();

  @override
  List<Object> get props => [version];
}

/// UnInitialized
class UnSettingsState extends SettingsState {
  UnSettingsState(int version) : super(version);

  @override
  String toString() => 'UnSettingsState';

  @override
  UnSettingsState getStateCopy() {
    return UnSettingsState(0);
  }

  @override
  UnSettingsState getNewVersion() {
    return UnSettingsState(version + 1);
  }
}

/// Initialized
class InSettingsState extends SettingsState {
  InSettingsState(int version, this.hello) : super(version);

  final String hello;

  @override
  String toString() => 'InSettingsState $hello';

  @override
  InSettingsState getStateCopy() {
    return InSettingsState(version, hello);
  }

  @override
  InSettingsState getNewVersion() {
    return InSettingsState(version + 1, hello);
  }

  @override
  List<Object> get props => [version, hello];
}

class RedirectState extends SettingsState {
  RedirectState(int version) : super(version);

  @override
  String toString() => 'InSettingsState';

  @override
  RedirectState getStateCopy() {
    return RedirectState(version);
  }

  @override
  RedirectState getNewVersion() {
    return RedirectState(version + 1);
  }

  @override
  List<Object> get props => [version];
}

class ErrorSettingsState extends SettingsState {
  ErrorSettingsState(int version, this.errorMessage) : super(version);

  final String errorMessage;

  @override
  String toString() => 'ErrorSettingsState';

  @override
  ErrorSettingsState getStateCopy() {
    return ErrorSettingsState(version, errorMessage);
  }

  @override
  ErrorSettingsState getNewVersion() {
    return ErrorSettingsState(version + 1, errorMessage);
  }

  @override
  List<Object> get props => [version, errorMessage];
}
