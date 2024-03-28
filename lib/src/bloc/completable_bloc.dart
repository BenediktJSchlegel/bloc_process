import 'package:bloc_process/src/bloc/interfaces/process_bloc_event.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_state.dart';
import 'package:bloc_process/src/bloc/middleware_bloc.dart';
import 'package:flutter/cupertino.dart';

abstract class CompletableBloc<TEvent extends ProcessBlocEvent, TState extends ProcessBlocState, TReturn>
    extends MiddlewareBloc<TEvent, TState> {
  @protected
  late final Future<void> Function(TReturn value) completeCallback;

  @protected
  late final Future<void> Function()? backOutCallback;

  CompletableBloc(super.initialState);

  Future<void> complete(TReturn value) async {
    await completeCallback.call(value);
  }

  Future<void> backOut() async {
    await backOutCallback?.call();
  }

  void mountCallbacks(
    Future<void> Function(TReturn value) callback,
    Future<void> Function() backOut,
  ) {
    completeCallback = callback;
    backOutCallback = backOut;
  }
}
