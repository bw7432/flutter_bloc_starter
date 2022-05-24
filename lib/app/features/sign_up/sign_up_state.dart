import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:flutter_starter/app/auth_models/confirm_password.dart';
import 'package:flutter_starter/app/auth_models/email.dart';
import 'package:flutter_starter/app/auth_models/password.dart';

abstract class SignUpState extends Equatable {
  SignUpState();

  /// notify change state without deep clone state

  /// Copy object for use in action
  /// if need use deep clone
  SignUpState getStateCopy();

  SignUpState getNewVersion();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnSignUpState extends SignUpState {
  UnSignUpState() : super();

  @override
  String toString() => 'UnSignUpState';

  @override
  UnSignUpState getStateCopy() {
    return UnSignUpState();
  }

  @override
  UnSignUpState getNewVersion() {
    return UnSignUpState();
  }
}

class SignUpSuccessState extends SignUpState {
  SignUpSuccessState() : super();

  @override
  String toString() => 'SignUpSuccessState';

  @override
  SignUpSuccessState getStateCopy() {
    return SignUpSuccessState();
  }

  @override
  SignUpSuccessState getNewVersion() {
    return SignUpSuccessState();
  }
}

/// Initialized
class InSignUpState extends SignUpState {
  InSignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.exceptionError = '',
    this.status = FormzStatus.pure,
  }) : super();

  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final String exceptionError;
  final FormzStatus status;

  @override
  String toString() => 'InSignUpState';

  @override
  InSignUpState getStateCopy() {
    return InSignUpState(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        exceptionError: '',
        status: status);
  }

  @override
  InSignUpState getNewVersion() {
    return InSignUpState(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        status: status);
  }

  @override
  List<Object> get props => [email, password, confirmPassword, status];

  InSignUpState copyWith({
    Email? email,
    Password? password,
    String? error,
    ConfirmPassword? confirmPassword,
    FormzStatus? status,
  }) {
    return InSignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      exceptionError: error ?? exceptionError,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
    );
  }
}

class IsSignUpState extends SignUpState {
  IsSignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.exceptionError = '',
    this.status = FormzStatus.pure,
  }) : super();

  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final String exceptionError;
  final FormzStatus status;

  @override
  String toString() => 'InSignUpState';

  @override
  InSignUpState getStateCopy() {
    return InSignUpState(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        exceptionError: '',
        status: status);
  }

  @override
  InSignUpState getNewVersion() {
    return InSignUpState(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        status: status);
  }

  @override
  List<Object> get props => [email, password, confirmPassword, status];

  InSignUpState copyWith({
    // String ? image,
    // Name ? name,
    Email? email,
    Password? password,
    String? error,
    ConfirmPassword? confirmPassword,
    FormzStatus? status,
  }) {
    return InSignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      exceptionError: error ?? exceptionError,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
    );
  }
}

class ErrorSignUpState extends SignUpState {
  ErrorSignUpState(this.errorMessage) : super();

  final String errorMessage;

  @override
  String toString() => 'ErrorSignUpState';

  @override
  ErrorSignUpState getStateCopy() {
    return ErrorSignUpState(errorMessage);
  }

  @override
  ErrorSignUpState getNewVersion() {
    return ErrorSignUpState(errorMessage);
  }

  @override
  List<Object> get props => [errorMessage];
}
