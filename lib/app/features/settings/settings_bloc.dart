import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_starter/app/features/settings/index.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  // todo: check singleton for logic in project
  // use GetIt for DI in projct
  static final SettingsBloc _settingsBlocSingleton = SettingsBloc._internal();
  factory SettingsBloc() {
    return _settingsBlocSingleton;
  }
  
  SettingsBloc._internal(): super(UnSettingsState(0)){
    on<SettingsEvent>((event, emit) {
      return emit.forEach<SettingsState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'SettingsBloc', error: error, stackTrace: stackTrace);
          return ErrorSettingsState(0, error.toString());
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
  SettingsState get initialState => UnSettingsState(0);

}
