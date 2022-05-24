import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:flutter_starter/app/auth_models/email.dart';
import 'package:flutter_starter/app/auth_models/password.dart';

abstract class LoginState extends Equatable {
  LoginState();

  /// Copy object for use in action
  /// if need use deep clone
  LoginState getStateCopy();

  LoginState getNewVersion();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnLoginState extends LoginState {
  UnLoginState() : super();

  @override
  String toString() => 'UnLoginState';

  @override
  UnLoginState getStateCopy() {
    return UnLoginState();
  }

  @override
  UnLoginState getNewVersion() {
    return UnLoginState();
  }
}

class LoginSuccessState extends LoginState {
  LoginSuccessState() : super();

  @override
  String toString() => 'UnLoginState';

  @override
  LoginSuccessState getStateCopy() {
    return LoginSuccessState();
  }

  @override
  LoginSuccessState getNewVersion() {
    return LoginSuccessState();
  }
}

/// Initialized
class InLoginState extends LoginState {
  InLoginState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure,
      this.exceptionError = '',
      this.accountExists = false,
      this.emailGuess = ''})
      : super();

  /// notify change state without deep clone state
  final Email email;
  final Password password;
  final FormzStatus status;
  final String exceptionError;
  final bool accountExists;
  final String emailGuess;

  @override
  String toString() => 'InLoginState';

  @override
  InLoginState getStateCopy() {
    return InLoginState(
        email: email,
        password: password,
        status: status,
        exceptionError: exceptionError,
        accountExists: accountExists,
        emailGuess: emailGuess);
  }

  @override
  InLoginState getNewVersion() {
    return InLoginState(
        email: email,
        password: password,
        status: status,
        exceptionError: exceptionError,
        accountExists: accountExists,
        emailGuess: emailGuess);
  }

  @override
  List<Object> get props =>
      [email, password, status, exceptionError, accountExists, emailGuess];

  InLoginState copyWith(
      {Email? email,
      Password? password,
      FormzStatus? status,
      String? error,
      bool? accountExists,
      String? emailGuess}) {
    return InLoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        exceptionError: error ?? exceptionError,
        accountExists: accountExists ?? this.accountExists,
        emailGuess: emailGuess ?? this.emailGuess);
  }
}

class ErrorLoginState extends LoginState {
  ErrorLoginState(this.errorMessage) : super();

  final String errorMessage;

  @override
  String toString() => 'ErrorLoginState';

  @override
  ErrorLoginState getStateCopy() {
    return ErrorLoginState(errorMessage);
  }

  @override
  ErrorLoginState getNewVersion() {
    return ErrorLoginState(errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}

class IsLoginState extends LoginState {
  IsLoginState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure,
      this.exceptionError = '',
      this.accountExists = false,
      this.emailGuess = ''})
      : super();

  /// notify change state without deep clone state
  final Email email;
  final Password password;
  final FormzStatus status;
  final String exceptionError;
  final bool accountExists;
  final String emailGuess;

  @override
  String toString() => 'InLoginState';

  @override
  IsLoginState getStateCopy() {
    return IsLoginState(
        email: email,
        password: password,
        status: status,
        exceptionError: exceptionError,
        accountExists: accountExists,
        emailGuess: emailGuess);
  }

  @override
  IsLoginState getNewVersion() {
    return IsLoginState(
        email: email,
        password: password,
        status: status,
        exceptionError: exceptionError,
        accountExists: accountExists,
        emailGuess: emailGuess);
  }

  @override
  List<Object> get props =>
      [email, password, status, exceptionError, accountExists, emailGuess];

  IsLoginState copyWith(
      {Email? email,
      Password? password,
      FormzStatus? status,
      String? error,
      bool? accountExists,
      String? emailGuess}) {
    return IsLoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        exceptionError: error ?? exceptionError,
        accountExists: accountExists ?? this.accountExists,
        emailGuess: emailGuess ?? this.emailGuess);
  }
}
