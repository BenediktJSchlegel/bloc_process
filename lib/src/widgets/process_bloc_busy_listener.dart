import 'dart:async';

import 'package:flutter/material.dart';

import '../../bloc_process.dart';

class ProcessBlocBusyListener<TBloc extends ProcessBloc> extends StatefulWidget {
  final TBloc bloc;
  final Widget child;
  final void Function(bool event) onBusyCallback;

  const ProcessBlocBusyListener({
    super.key,
    required this.bloc,
    required this.onBusyCallback,
    required this.child,
  });

  @override
  State<ProcessBlocBusyListener> createState() => _ProcessBlocBusyListenerState<TBloc>();
}

class _ProcessBlocBusyListenerState<TBloc extends ProcessBloc> extends State<ProcessBlocBusyListener> {
  StreamSubscription? _busySubscription;

  @override
  void initState() {
    super.initState();

    _busySubscription = widget.bloc.busyStream.listen((event) {
      widget.onBusyCallback.call(event);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _busySubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
