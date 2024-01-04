import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_process.dart';

/// `BlocConsumer` widget - extended with support for the `ProcessBloc`s error stream.
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
class ProcessBlocConsumer<
        TInput,
        TEvent extends ProcessBlocEvent,
        TState extends ProcessBlocState,
        TOutput,
        TBloc extends ProcessBloc<TInput, TEvent, TState, TOutput>>
    extends StatefulWidget {
  final Function(ErrorEvent event)? onErrorCallback;
  final TBloc bloc;
  final BlocListenerCondition<TState>? listenWhen;
  final BlocBuilderCondition<TState>? buildWhen;
  final BlocWidgetBuilder<TState> builder;
  final BlocWidgetListener<TState> listener;

  const ProcessBlocConsumer({
    super.key,
    required this.builder,
    required this.bloc,
    required this.onErrorCallback,
    required this.listener,
    this.listenWhen,
    this.buildWhen,
  });

  @override
  State<ProcessBlocConsumer> createState() =>
      _ProcessBlocConsumerState<TInput, TEvent, TState, TOutput, TBloc>();
}

class _ProcessBlocConsumerState<
        TInput,
        TEvent extends ProcessBlocEvent,
        TState extends ProcessBlocState,
        TReturn,
        TBloc extends ProcessBloc<TInput, TEvent, TState, TReturn>>
    extends State<ProcessBlocConsumer<TInput, TEvent, TState, TReturn, TBloc>> {
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
    return BlocConsumer<TBloc, TState>(
      key: widget.key,
      bloc: widget.bloc,
      listenWhen: widget.listenWhen,
      buildWhen: widget.buildWhen,
      builder: widget.builder,
      listener: widget.listener,
    );
  }
}
