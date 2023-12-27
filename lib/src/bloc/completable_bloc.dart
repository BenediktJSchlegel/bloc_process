import 'package:bloc_process/src/bloc/interfaces/process_bloc_event.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CompletableBloc<TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState, TReturn> extends Bloc<TEvent, TState> {
  @protected
  late final void Function(TReturn value) completeCallback;

  CompletableBloc(super.initialState);

  void complete(TReturn value) {
    completeCallback.call(value);
  }

  void mountCallback(void Function(TReturn value) callback) {
    completeCallback = callback;
  }
}
