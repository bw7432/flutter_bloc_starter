import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_starter/app/features/sign_up/index.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  // todo: check singleton for logic in project
  // use GetIt for DI in projct
  static final SignUpBloc _signUpBlocSingleton = SignUpBloc._internal();
  factory SignUpBloc() {
    return _signUpBlocSingleton;
  }

  SignUpBloc._internal() : super(UnSignUpState()) {
    on<SignUpEvent>((event, emit) {
      return emit.forEach<SignUpState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error',
              name: 'SignUpBloc', error: error, stackTrace: stackTrace);
          return ErrorSignUpState(error.toString());
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
  SignUpState get initialState => UnSignUpState();
}
