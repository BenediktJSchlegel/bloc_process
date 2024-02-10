import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BlocChannel<TEvent, TState,
    TBloc extends MultiChannelProcessBloc> {
  final TBloc _bloc;

  BlocChannel(this._bloc);

  @nonVirtual
  bool isHandledBy(dynamic o) => o is TEvent;

  void apply(TEvent event, Emitter<TState> emit);

  void emitError(ErrorEvent event) {
    _bloc.emitError(event);
  }

  void add(ProcessBlocEvent event) {
    _bloc.add(event);
  }

  @protected
  TBloc get bloc => _bloc;
}
