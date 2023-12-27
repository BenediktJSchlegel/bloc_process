import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../bloc_process.dart';
import '../error/error_event.dart';
import 'completable_bloc.dart';

class ErrorProducingBloc<
    TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState,
    TReturn> extends CompletableBloc<TEvent, TState, TReturn> {
  late final StreamController<ErrorEvent> _controller;

  ErrorProducingBloc(super.initialState) {
    _mountErrorStream();
  }

  void _mountErrorStream() {
    _controller = StreamController<ErrorEvent>.broadcast(
      sync: false,
      onCancel: _onCancel,
      onListen: _onListen,
    );
  }

  void _onCancel() {}

  void _onListen() {}

  Stream<ErrorEvent> get errorStream => _controller.stream;

  void emitError(ErrorEvent event) {
    _controller.add(event);
  }

  @mustCallSuper
  @override
  Future<void> close() async {
    _controller.close();

    return super.close();
  }
}
