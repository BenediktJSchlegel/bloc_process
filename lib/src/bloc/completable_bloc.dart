import 'package:bloc_process/src/bloc/interfaces/process_bloc_event.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_state.dart';
import 'package:bloc_process/src/bloc/middleware_bloc.dart';
import 'package:flutter/cupertino.dart';

abstract class CompletableBloc<
    TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState,
    TReturn> extends MiddlewareBloc<TEvent, TState> {
  @protected
  late final void Function(TReturn value) completeCallback;

  @protected
  late final void Function()? backOutCallback;

  CompletableBloc(super.initialState);

  void complete(TReturn value) {
    completeCallback.call(value);
  }

  void backOut() {
    backOutCallback?.call();
  }

  void mountCallbacks(
    void Function(TReturn value) callback,
    void Function() backOut,
  ) {
    completeCallback = callback;
    backOutCallback = backOut;
  }
}
