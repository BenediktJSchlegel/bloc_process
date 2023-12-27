import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_process.dart';
import '../error/error_event.dart';

class ProcessBlocConsumer<
    TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState,
    TReturn,
    TBloc extends ProcessBloc<TEvent, TState, TReturn>> extends StatefulWidget {
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
      _ProcessBlocConsumerState<TEvent, TState, TReturn, TBloc>();
}

class _ProcessBlocConsumerState<
        TEvent extends ProcessBlocEvent,
        TState extends ProcessBlocState,
        TReturn,
        TBloc extends ProcessBloc<TEvent, TState, TReturn>>
    extends State<ProcessBlocConsumer<TEvent, TState, TReturn, TBloc>> {
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
