import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/widgets.dart';

class DecisionLink<TInput, TOutput> extends ChainLink<TInput, TOutput> {
  final bool Function(TInput input) _condition;
  final ChainLink _then;
  final ChainLink _elseThen;

  DecisionLink({
    required bool Function(TInput input) condition,
    required ChainLink then,
    required ChainLink elseThen,
    dynamic Function(TOutput output)? outputTransformer,
    TInput Function(dynamic input)? inputTransformer,
  })  : _condition = condition,
        _then = then,
        _elseThen = elseThen,
        super(
          inputTransformer: inputTransformer,
          outputTransformer: outputTransformer,
        );

  @override
  void start(BuildContext context, TInput input) {
    _startNextLink(context, _condition(input) ? _then : _elseThen, input);
  }

  void _startNextLink(BuildContext context, ChainLink link, TInput input) {
    dynamic nextInput = _applyInputTransformer(link, input);

    _checkNextInput(link, nextInput);

    link.onEnd = _onLinkCompleted;
    link.start(context, nextInput);
  }

  void _checkNextInput(ChainLink link, dynamic input) {
    if (!link.isInputType(input)) {
      throw TypeIOError(input, link.inputType);
    }
  }

  dynamic _applyInputTransformer(ChainLink link, dynamic input) {
    if (link.inputTransformer != null) {
      return link.inputTransformer!.call(input);
    }

    return input;
  }

  void _onLinkCompleted(dynamic output) {
    dynamic finalOutput =
        outputTransformer != null ? outputTransformer!.call(output) : output;

    if (!isOutputType(finalOutput)) {
      throw TypeIOError(finalOutput, TOutput);
    }

    _onCompleted(output as TOutput);
  }

  void _onCompleted(TOutput output) {
    if (super.outputTransformer != null) {
      onEnd!.call(super.outputTransformer!.call(output));

      return;
    }

    onEnd!.call(output);
  }
}
