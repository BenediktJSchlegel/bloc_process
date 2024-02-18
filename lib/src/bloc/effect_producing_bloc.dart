import 'dart:async';

import 'package:bloc_process/src/bloc/error_producing_bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc_process.dart';
import '../effects/effect.dart';
import '../error/error_event.dart';
import 'completable_bloc.dart';

class EffectProducingBloc<
    TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState,
    TReturn> extends ErrorProducingBloc<TEvent, TState, TReturn> {
  late final StreamController<Effect> _controller;

  EffectProducingBloc(super.initialState) {
    _mountEffectStream();
  }

  void _mountEffectStream() {
    _controller = StreamController<Effect>.broadcast(
      sync: false,
      onCancel: _onCancel,
      onListen: _onListen,
    );
  }

  void _onCancel() {}

  void _onListen() {}

  Stream<Effect> get effectStream => _controller.stream;

  void emitEffect(Effect event) {
    effectMiddleware?.forEach((middleware) {
      middleware.onEffect(event);
    });

    _controller.add(event);
  }

  @mustCallSuper
  @override
  Future<void> close() async {
    _controller.close();

    return super.close();
  }
}
