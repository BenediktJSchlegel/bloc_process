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
    dynamic Function(TOutput output)? outputTransformer,
    TInput Function(dynamic input)? inputTransformer,
  }) : super(
          inputTransformer: inputTransformer,
          outputTransformer: outputTransformer,
        );

  @override
  void start(BuildContext context, TInput input) {
    _controller.start(context, input, _onControllerCompleted);
  }

  void _onControllerCompleted(TOutput output) {
    if (super.outputTransformer != null) {
      onEnd!.call(super.outputTransformer!.call(output));
      return;
    }

    onEnd!.call(output);
  }
}
