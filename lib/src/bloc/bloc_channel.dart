import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BlocChannel<TEvent extends ProcessBlocEvent, TState extends ProcessBlocState,
    TBloc extends MultiChannelProcessBloc<dynamic, dynamic, TState, dynamic>> {
  final TBloc _bloc;

  BlocChannel(this._bloc);

  @nonVirtual
  bool isHandledBy(dynamic o) => o is TEvent;

  Future<void> onEvent(TEvent event, Emitter<TState> emit);

  void emitError(ErrorEvent event) {
    _bloc.emitError(event);
  }

  void add(TEvent event) {
    _bloc.add(event);
  }

  @protected
  void emitEffect(Effect effect) {
    _bloc.emitEffect(effect);
  }

  @protected
  void complete(dynamic output) {
    _bloc.complete(output);
  }

  @protected
  TBloc get bloc => _bloc;

  @protected
  TState get state => _bloc.state;
}
