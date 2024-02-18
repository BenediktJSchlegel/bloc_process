import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_process.dart';

abstract class MiddlewareBloc<TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState> extends Bloc<TEvent, TState> {
  List<Middleware>? _middleware;

  MiddlewareBloc(super.initialState);

  void mountMiddleware(List<Middleware> middleware) {
    _middleware = middleware;

    stream.listen((state) {
      stateMiddleware?.forEach((middleware) {
        middleware.onStateChanged(state);
      });
    });
  }

  @protected
  List<Middleware>? get middleware => _middleware;

  @protected
  List<EffectMiddleware>? get effectMiddleware =>
      _middleware?.whereType<EffectMiddleware>().toList();

  @protected
  List<ErrorMiddleware>? get errorMiddleware =>
      _middleware?.whereType<ErrorMiddleware>().toList();

  @protected
  List<StateMiddleware>? get stateMiddleware =>
      _middleware?.whereType<StateMiddleware>().toList();

  @protected
  List<EventMiddleware>? get eventMiddleware =>
      _middleware?.whereType<EventMiddleware>().toList();
}
