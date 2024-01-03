import 'package:bloc_process/src/chain/links/chain_link.dart';
import 'package:flutter/widgets.dart';

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
