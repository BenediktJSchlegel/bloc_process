import 'package:flutter/cupertino.dart';

import '../../../bloc_process.dart';

class ProcessLink<
    TInput,
    TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState,
    TOutput,
    TBloc extends ProcessBloc<TInput, TEvent, TState, TOutput>,
    TNavigator extends ProcessNavigator<TBloc, TState>,
    TProcess extends ProcessController<TInput, TEvent, TState, TOutput, TBloc,
        TNavigator>> extends ChainLink<TInput, TOutput> {
  final TProcess _controller;

  ProcessLink(
    this._controller, {
    required dynamic Function(TOutput output)? transformer,
  }) : super(transformer);

  @override
  void start(BuildContext context, TInput input) {
    _controller.start(context, input, _onControllerCompleted);
  }

  void _onControllerCompleted(TOutput output) {
    if (super.transformer != null) {
      onEnd!.call(super.transformer!.call(output));
      return;
    }

    onEnd!.call(output);
  }
}
