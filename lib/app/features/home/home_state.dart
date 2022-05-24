import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  HomeState(this.version);
 
  /// notify change state without deep clone state
  final int version;

  /// Copy object for use in action
  /// if need use deep clone
  HomeState getStateCopy();

  HomeState getNewVersion();

  @override
  List<Object> get props => [version];
}

/// UnInitialized
class UnHomeState extends HomeState {

  UnHomeState(int version) : super(version);

  @override
  String toString() => 'UnHomeState';

  @override
  UnHomeState getStateCopy() {
    return UnHomeState(0);
  }

  @override
  UnHomeState getNewVersion() {
    return UnHomeState(version+1);
  }
}

/// Initialized
class InHomeState extends HomeState {
  
  InHomeState(int version, this.hello) : super(version);
 
  final String hello;

  @override
  String toString() => 'InHomeState $hello';

  @override
  InHomeState getStateCopy() {
    return InHomeState(version, hello);
  }

  @override
  InHomeState getNewVersion() {
    return InHomeState(version+1, hello);
  }

  @override
  List<Object> get props => [version, hello];
}

class ErrorHomeState extends HomeState {
  ErrorHomeState(int version, this.errorMessage): super(version);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorHomeState';

  @override
  ErrorHomeState getStateCopy() {
    return ErrorHomeState(version, errorMessage);
  }

  @override
  ErrorHomeState getNewVersion() {
    return ErrorHomeState(version+1, 
    errorMessage);
  }

  @override
  List<Object> get props => [version, errorMessage];
}
