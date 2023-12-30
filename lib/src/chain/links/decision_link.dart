import 'package:flutter/widgets.dart';

import '../links/chain_link.dart';

class DecisionLink<TInput, TOutput> extends ChainLink<TInput, TOutput> {
  final bool Function(TInput input) _condition;
  final ChainLink _then;
  final ChainLink _elseThen;

  DecisionLink({
    required bool Function(TInput input) condition,
    required ChainLink then,
    required ChainLink elseThen,
    required dynamic Function(TOutput output)? outputTransformer,
    required TInput Function(dynamic input)? inputTransformer,
  })  : _condition = condition,
        _then = then,
        _elseThen = elseThen,
        super(
          inputTransformer: inputTransformer,
          outputTransformer: outputTransformer,
        );

  @override
  void start(BuildContext context, TInput input) {
    if (_condition(input)) {
      _then.onEnd = _onLinkCompleted;
      _then.start(context, input);
    } else {
      _elseThen.onEnd = _onLinkCompleted;
      _elseThen.start(context, input);
    }
  }

  void _onLinkCompleted(dynamic output) {
    if (!isOutputType(output)) {
      // Throw better error. -> output of sublink is not output of this
      throw Error();
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
