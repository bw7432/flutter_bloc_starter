import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math';
import 'package:formz/formz.dart';
import 'package:flutter_starter/app/auth_models/email.dart';
import 'package:flutter_starter/app/auth_models/password.dart';
import 'package:flutter_starter/app/features/login/index.dart';
import 'package:meta/meta.dart';
import 'package:flutter_starter/app/repository/user_repository.dart';

@immutable
abstract class LoginEvent {
  Stream<LoginState> applyAsync({LoginState currentState, LoginBloc bloc});
  final UserRepository _userRepository = UserRepository();
}

class UnLoginEvent extends LoginEvent {
  @override
  Stream<LoginState> applyAsync(
      {LoginState? currentState, LoginBloc? bloc}) async* {
    yield UnLoginState();
  }
}

class LoadLoginEvent extends LoginEvent {
  final bool isError;
  @override
  String toString() => 'LoadLoginEvent';

  LoadLoginEvent(this.isError);

  @override
  Stream<LoginState> applyAsync(
      {LoginState? currentState, LoginBloc? bloc}) async* {
    try {
      yield UnLoginState();
      yield InLoginState();
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorLoginState(_.toString());
    }
  }
}

class EmailLoginChangedEvent extends LoginEvent {
  final String value;
  @override
  String toString() => 'LoadLoginEvent';

  EmailLoginChangedEvent(this.value);

  @override
  Stream<LoginState> applyAsync(
      {LoginState? currentState, LoginBloc? bloc}) async* {
    try {
      yield UnLoginState();

      if (currentState is InLoginState) {
        final email = Email.dirty(value);
        var state = currentState.copyWith(
            email: email,
            status: Formz.validate([email, currentState.password]));

        yield UnLoginState();

        yield InLoginState(
          email: email,
          password: state.password,
          status: state.status,
          exceptionError: '',
          accountExists: state.accountExists,
          emailGuess: state.emailGuess,
        );
      } else {
        yield InLoginState();
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorLoginState(_.toString());
    }
  }
}

class PasswordLoginChangedEvent extends LoginEvent {
  final String value;
  @override
  String toString() => 'LoadLoginEvent';

  PasswordLoginChangedEvent(this.value);

  @override
  Stream<LoginState> applyAsync(
      {LoginState? currentState, LoginBloc? bloc}) async* {
    try {
      yield UnLoginState();
      if (currentState is InLoginState) {
        final password = Password.dirty(value);
        var state = currentState.copyWith(
            password: password,
            status: Formz.validate([currentState.email, password]));

        yield UnLoginState();

        yield InLoginState(
            email: state.email,
            password: password,
            status: state.status,
            exceptionError: '',
            accountExists: state.accountExists,
            emailGuess: state.emailGuess);
      } else {
        yield InLoginState();
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorLoginState(_.toString());
    }
  }
}

class DoLoginEvent extends LoginEvent {
  @override
  String toString() => 'LoadLoginEvent';

  DoLoginEvent();

  @override
  Stream<LoginState> applyAsync(
      {LoginState? currentState, LoginBloc? bloc}) async* {
    // try {
    if (currentState is InLoginState) {
      var state = currentState.getStateCopy();
      try {
        yield IsLoginState(
            email: state.email,
            password: state.password,
            status: state.status,
            exceptionError: state.exceptionError,
            accountExists: state.accountExists,
            emailGuess: state.emailGuess);
        // run code to sign in
        var body = {
          "email": state.email.value,
          "password": state.password.value
        };
        await _userRepository.signIn(body);
        yield LoginSuccessState();
      } catch (_, stackTrace) {
        // show response error
        yield InLoginState(
            email: state.email,
            password: state.password,
            status: state.status,
            exceptionError: 'Error: please try again',
            accountExists: state.accountExists,
            emailGuess: state.emailGuess);
      }
    }
  }
}

const chars = "abcdefghijklmnopqrstuvwxyz0123456789";

String randomString(int strlen) {
  Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < strlen; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result;
}
