import 'dart:async';

import 'package:bloc_process/src/bloc/process_bloc.dart';
import 'package:flutter/widgets.dart';

import '../error/error_event.dart';

/// Allows listening to the given [bloc]'s error stream.
class ProcessBlocErrorListener<TBloc extends ProcessBloc>
    extends StatefulWidget {
  final TBloc bloc;
  final Widget child;
  final void Function(ErrorEvent event) onErrorCallback;

  const ProcessBlocErrorListener({
    super.key,
    required this.bloc,
    required this.child,
    required this.onErrorCallback,
  });

  @override
  State<ProcessBlocErrorListener> createState() =>
      _ProcessBlocErrorListenerState();
}

class _ProcessBlocErrorListenerState extends State<ProcessBlocErrorListener> {
  StreamSubscription? _errorSubscription;

  @override
  void initState() {
    super.initState();

    _errorSubscription = widget.bloc.errorStream.listen((event) {
      widget.onErrorCallback.call(event);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _errorSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
