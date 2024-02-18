import 'package:bloc_process/src/bloc/interfaces/process_bloc_event.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_state.dart';
import 'package:bloc_process/src/bloc/middleware_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CompletableBloc<
    TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState,
    TReturn> extends MiddlewareBloc<TEvent, TState> {
  @protected
  late final void Function(TReturn value) completeCallback;

  @protected
  late final void Function(int steps)? backOutCallback;

  CompletableBloc(super.initialState);

  void complete(TReturn value) {
    completeCallback.call(value);
  }

  void backOut(int steps) {
    backOutCallback?.call(steps);
  }

  void mountCallbacks(
    void Function(TReturn value) callback,
    void Function(int steps) backOut,
  ) {
    completeCallback = callback;
    backOutCallback = backOut;
  }
}
