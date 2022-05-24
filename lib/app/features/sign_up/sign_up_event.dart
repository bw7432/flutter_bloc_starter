import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:formz/formz.dart';
import 'package:flutter_starter/app/auth_models/confirm_password.dart';
import 'package:flutter_starter/app/auth_models/email.dart';
import 'package:flutter_starter/app/auth_models/password.dart';
import 'package:flutter_starter/app/features/sign_up/index.dart';
import 'package:meta/meta.dart';
import 'package:flutter_starter/app/repository/user_repository.dart';

@immutable
abstract class SignUpEvent {
  Stream<SignUpState> applyAsync({SignUpState currentState, SignUpBloc bloc});
  final UserRepository _userRepository = UserRepository();
}

class UnSignUpEvent extends SignUpEvent {
  @override
  Stream<SignUpState> applyAsync(
      {SignUpState? currentState, SignUpBloc? bloc}) async* {
    yield UnSignUpState();
  }
}

class LoadSignUpEvent extends SignUpEvent {
  final bool isError;
  @override
  String toString() => 'LoadSignUpEvent';

  LoadSignUpEvent(this.isError);

  @override
  Stream<SignUpState> applyAsync(
      {SignUpState? currentState, SignUpBloc? bloc}) async* {
    try {
      yield UnSignUpState();
      yield InSignUpState();
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadSignUpEvent', error: _, stackTrace: stackTrace);
      yield ErrorSignUpState(_.toString());
    }
  }
}

class EmailSignUpChangedEvent extends SignUpEvent {
  final String value;
  @override
  String toString() => 'LoadSignUpEvent';

  EmailSignUpChangedEvent(this.value);

  @override
  Stream<SignUpState> applyAsync(
      {SignUpState? currentState, SignUpBloc? bloc}) async* {
    try {
      yield UnSignUpState();

      if (currentState is InSignUpState) {
        final email = Email.dirty(value);
        var state = currentState.copyWith(
            email: email,
            status: Formz.validate(
                [email, currentState.password, currentState.confirmPassword]));

        yield UnSignUpState();

        yield InSignUpState(
          email: email,
          password: state.password,
          confirmPassword: state.confirmPassword,
          status: state.status,
        );
      } else {
        yield InSignUpState();
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadSignUpEvent', error: _, stackTrace: stackTrace);
      yield ErrorSignUpState(_.toString());
    }
  }
}

class PasswordSignUpChangedEvent extends SignUpEvent {
  final String value;
  @override
  String toString() => 'LoadSignUpEvent';

  PasswordSignUpChangedEvent(this.value);

  @override
  Stream<SignUpState> applyAsync(
      {SignUpState? currentState, SignUpBloc? bloc}) async* {
    try {
      yield UnSignUpState();
      if (currentState is InSignUpState) {
        final password = Password.dirty(value);
        var state = currentState.copyWith(
            password: password,
            status: Formz.validate(
                [currentState.email, password, currentState.confirmPassword]));

        yield UnSignUpState();

        yield InSignUpState(
          email: state.email,
          password: password,
          confirmPassword: state.confirmPassword,
          status: state.status,
        );
      } else {
        yield InSignUpState();
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadSignUpEvent', error: _, stackTrace: stackTrace);
      yield ErrorSignUpState(_.toString());
    }
  }
}

class ConfirmPasswordSignUpChangedEvent extends SignUpEvent {
  final String value;
  @override
  String toString() => 'LoadSignUpEvent';

  ConfirmPasswordSignUpChangedEvent(this.value);

  @override
  Stream<SignUpState> applyAsync(
      {SignUpState? currentState, SignUpBloc? bloc}) async* {
    try {
      yield UnSignUpState();

      if (currentState is InSignUpState) {
        final confirmPassword = ConfirmPassword.dirty(
            password: currentState.password.value, value: value);
        var state = currentState.copyWith(
            confirmPassword: confirmPassword,
            status: Formz.validate(
                [currentState.email, currentState.password, confirmPassword]));

        yield UnSignUpState();

        yield InSignUpState(
          email: state.email,
          password: state.password,
          confirmPassword: confirmPassword,
          status: state.status,
        );
      } else {
        yield InSignUpState();
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadSignUpEvent', error: _, stackTrace: stackTrace);
      yield ErrorSignUpState(_.toString());
    }
  }
}

class DoSignUpEvent extends SignUpEvent {
  @override
  String toString() => 'LoadLoginEvent';

  DoSignUpEvent();

  @override
  Stream<SignUpState> applyAsync(
      {SignUpState? currentState, SignUpBloc? bloc}) async* {
    if (currentState is InSignUpState) {
      var state = currentState.getStateCopy();
      try {
        yield IsSignUpState(
            email: state.email,
            password: state.password,
            status: state.status,
            exceptionError: state.exceptionError);

        var body = json.encode({
          "password": state.password.value,
          "password_confirmation": state.confirmPassword.value,
          "email": state.email.value,
          "confirm_success_url": null
        });

        await _userRepository.signUp(body);
        yield SignUpSuccessState();
      } catch (_, stackTrace) {
        // show response error
        yield InSignUpState(
            email: state.email,
            password: state.password,
            confirmPassword: state.confirmPassword,
            status: state.status,
            exceptionError: 'Error: please try again');
      }
    }
  }
}
