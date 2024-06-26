import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/widgets.dart';

/// Allows for optional branching within a `ProcessChain`
class DecisionLink<TInput, TOutput> extends ChainLink<TInput, TOutput> {
  final bool Function(TInput input) _condition;
  final ChainLink _then;
  final ChainLink _elseThen;

  Future<void> Function(dynamic output)? onBreakout;

  /// Creates a new `DecisionLink`. If [condition] evaluates to `true`, the [then] `ChainLink` is started.
  /// otherwise the [elseThen] `ChainLink` is started. Input may be transformed by [inputTransformer], Output may be transformed by [outputTransformer]
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

  ChainLink get then => _then;

  ChainLink get elseThen => _elseThen;

  @override
  void start(BuildContext context, TInput input) {
    _startNextLink(context, _condition(input) ? _then : _elseThen, input);
  }

  void _startNextLink(BuildContext context, ChainLink link, TInput input) {
    dynamic nextInput = _applyInputTransformer(link, input);

    _checkNextInput(link, nextInput);

    link.onEnd = (out) => _onLinkCompleted(out, link is BreakoutLink);
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

  Future<void> _onLinkCompleted(dynamic output, bool breakout) async {
    dynamic finalOutput = outputTransformer != null ? outputTransformer!.call(output) : output;

    if (!isOutputType(finalOutput)) {
      throw TypeIOError(finalOutput, TOutput);
    }

    await _onCompleted(output as TOutput, breakout);
  }

  Future<void> _onCompleted(TOutput output, bool breakout) async {
    if (super.outputTransformer != null) {
      await _callEnd(super.outputTransformer!.call(output), breakout);

      return;
    }

    await _callEnd(output, breakout);
  }

  Future<void> _callEnd(TOutput output, bool breakout) async {
    if (breakout) {
      await onBreakout!.call(output);
    } else {
      await onEnd!.call(output);
    }
  }
}
