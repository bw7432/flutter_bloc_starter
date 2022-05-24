import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_starter/app/features/login/index.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // todo: check singleton for logic in project
  // use GetIt for DI in projct
  static final LoginBloc _loginBlocSingleton = LoginBloc._internal();
  factory LoginBloc() {
    return _loginBlocSingleton;
  }

  LoginBloc._internal() : super(UnLoginState()) {
    on<LoginEvent>((event, emit) {
      return emit.forEach<LoginState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error',
              name: 'LoginBloc', error: error, stackTrace: stackTrace);
          return ErrorLoginState(error.toString());
        },
      );
    });
  }

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  LoginState get initialState => UnLoginState();
}
