import 'package:flutter/cupertino.dart';

import '../../../bloc_process.dart';

///
///
/// `TInput`: the type for the process input
///
/// `TEvent` of Type `ProcessBlocEvent`: the type of the event classes
///
/// `TState` of Type `ProcessBlocState`: the type of the state object
///
/// `TOutput`: the type of the process output
///
/// `TBloc` of type `ProcessBloc`: type of the bloc controlling this link's process
///
/// `TNavigator` of type `ProcessNavigator`: type of the navigator responsible for this link's process
///
/// `TProcess` of type `ProcessController`: type of the controller started by this link
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

  void Function(ProcessLink callingLink)? onBackOut;

  ProcessLink? backOutReference;

  /// Creates a new `ProcessLink` using the given `ProcessController` [_controller].
  /// The input and output can optionally be transformed using [inputTransformer] and [outputTransformer]
  ProcessLink(
    this._controller, {
    this.backOutReference,
    dynamic Function(TOutput output)? outputTransformer,
    TInput Function(dynamic input)? inputTransformer,
  }) : super(
          inputTransformer: inputTransformer,
          outputTransformer: outputTransformer,
        );

  @override
  void start(BuildContext context, TInput input) {
    _controller.start(
        context, input, _onControllerCompleted, _onControlledBackedOut);
  }

  void revive() {
    _controller.revive();
  }

  void fullyClose() {
    _controller.fullyClose();
  }

  bool isStarted() => _controller.isStarted();

  void _onControllerCompleted(TOutput output) {
    if (super.outputTransformer != null) {
      onEnd!.call(super.outputTransformer!.call(output));
      return;
    }

    onEnd!.call(output);
  }

  void _onControlledBackedOut() {
    onBackOut?.call(this);
  }
}
