import 'package:bloc_process/src/helper/is_typed.dart';
import 'package:flutter/cupertino.dart';

import '../../../bloc_process.dart';

class FullChain {
  final BuildContext _context;
  final List<ChainLink> _links = [];
  int index = 0;

  FullChain(this._context);

  void setup() {
    _links.forEach((ChainLink link) {
      link.onEnd = onEnd;
    });
  }

  void start(dynamic lastOutput) {
    ChainLink nextLink = _links[index];

    if (nextLink.inputType != lastOutput) {
      // TODO: check how this acts with subtypes
      throw Error(); // TODO: Change error
    }

    _links[index].go(_context, lastOutput);
  }

  void onEnd(dynamic output) {
    index++;

    start(output);
  }
}

class ChainLink<
    TInput,
    TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState,
    TReturn,
    TBloc extends ProcessBloc<TInput, TEvent, TState, TReturn>,
    TNavigator extends ProcessNavigator<TBloc, TState>,
    TProcess extends ProcessController<TInput, TEvent, TState, TReturn, TBloc,
        TNavigator>> with IsTyped<TInput> {
  final TProcess _controller;
  final dynamic Function(TReturn output)? _transformer;

  Type get inputType => TInput.runtimeType;
  Type get outputType => TReturn.runtimeType;

  ChainLink(this._controller, this._transformer);

  void Function(dynamic output)? onEnd;

  void go(BuildContext context, TInput input) {
    // do something
    _controller.start(context, input, _onControllerCompleted);
  }

  void _onControllerCompleted(TReturn output) {}

  void end(TReturn output) {
    if (_transformer != null) {
      onEnd?.call(_transformer.call(output));
      return;
    }

    onEnd?.call(output);
  }
}
