import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_starter/app/features/home/index.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // todo: check singleton for logic in project
  // use GetIt for DI in projct
  static final HomeBloc _homeBlocSingleton = HomeBloc._internal();
  factory HomeBloc() {
    return _homeBlocSingleton;
  }
  
  HomeBloc._internal(): super(UnHomeState(0)){
    on<HomeEvent>((event, emit) {
      return emit.forEach<HomeState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'HomeBloc', error: error, stackTrace: stackTrace);
          return ErrorHomeState(0, error.toString());
        },
      );
    });
  }
  
  @override
  Future<void> close() async{
    // dispose objects
    await super.close();
  }

  @override
  HomeState get initialState => UnHomeState(0);

}
