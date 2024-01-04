import 'package:bloc_process/src/chain/links/chain_link.dart';
import 'package:flutter/widgets.dart';

/// `BreakoutLink` is a `ChainLink` that terminates the `ProcessChain` prematurely.
/// Termination happens after the optional [inputTransformer] and [outputTransformer] are called on the `TInput` input value.
class BreakoutLink<TInput> extends ChainLink<TInput, TInput> {
  BreakoutLink({
    super.inputTransformer,
    super.outputTransformer,
  });

  @override
  void start(BuildContext context, TInput input) {
    if (super.outputTransformer != null) {
      super.onEnd!.call(super.outputTransformer!.call(input));

      return;
    }

    super.onEnd!.call(input);
  }
}
