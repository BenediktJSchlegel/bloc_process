import 'dart:async';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_process.dart';

/// `BlocListener` widget - extended with support for the `ProcessBloc`s error stream.
///
/// `TInput`: the type for the process input
///
/// `TEvent` of Type `ProcessBlocEvent`: the type of the event classes
///
/// `TState` of Type `ProcessBlocState`: the type of the state object
///
/// `TOutput`: the type of the process output
///
/// `TBloc` of type `ProcessBloc`: type of the bloc controlling this process
class ProcessBlocListener<
        TInput,
        TEvent extends ProcessBlocEvent,
        TState extends ProcessBlocState,
        TReturn,
        TBloc extends ProcessBloc<TInput, TEvent, TState, TReturn>>
    extends StatefulWidget {
  final Function(ErrorEvent event)? onErrorCallback;
  final TBloc bloc;
  final BlocWidgetListener<TState> listener;
  final BlocListenerCondition<TState>? listenWhen;
  final Widget? child;

  const ProcessBlocListener({
    super.key,
    required this.bloc,
    required this.onErrorCallback,
    required this.listener,
    this.listenWhen,
    this.child,
  });

  @override
  State<ProcessBlocListener> createState() => _ProcessBlocListenerState();
}

class _ProcessBlocListenerState<
        TInput,
        TEvent extends ProcessBlocEvent,
        TState extends ProcessBlocState,
        TReturn,
        TBloc extends ProcessBloc<TInput, TEvent, TState, TReturn>>
    extends State<ProcessBlocListener<TInput, TEvent, TState, TReturn, TBloc>> {
  StreamSubscription? _errorSubscription;

  @override
  void initState() {
    super.initState();

    _errorSubscription = widget.bloc.errorStream.listen((event) {
      widget.onErrorCallback?.call(event);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _errorSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TBloc, TState>(
      bloc: widget.bloc,
      key: widget.key,
      listenWhen: widget.listenWhen,
      listener: widget.listener,
      child: widget.child,
    );
  }
}
