import 'dart:async';

import 'package:flutter/material.dart';

import '../../bloc_process.dart';
import 'effect_producing_bloc.dart';

class BusySettingBloc<TEvent extends ProcessBlocEvent, TState extends ProcessBlocState, TReturn>
    extends EffectProducingBloc<TEvent, TState, TReturn> {
  bool _isBusy = false;
  int _busyCount = 0;

  late final StreamController<bool> _controller;

  BusySettingBloc(super.initialState) {
    _mountBusyStream();
  }

  void setBusy() {
    _busyCount++;

    if (!_isBusy) {
      _emitBusy(true);
    }
  }

  void setNotBusy() {
    _busyCount--;

    if (_busyCount == 0) {
      _emitBusy(false);
    }
  }

  bool get isBusy => _isBusy;

  void _mountBusyStream() {
    _controller = StreamController<bool>.broadcast(
      sync: false,
      onCancel: _onCancel,
      onListen: _onListen,
    );
  }

  void _onCancel() {}

  void _onListen() {}

  Stream<bool> get busyStream => _controller.stream;

  void _emitBusy(bool busy) {
    _isBusy = busy;

    if(!_controller.isClosed){
      _controller.add(busy);
    }
  }

  @override
  @mustCallSuper
  Future<void> close() async {
    _controller.close();

    return super.close();
  }
}
