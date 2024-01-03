import 'package:flutter/widgets.dart';

import '../../../bloc_process.dart';

class PassLink<TInputOutput> extends ChainLink<TInputOutput, TInputOutput> {
  PassLink({
    super.outputTransformer,
    super.inputTransformer,
  });

  @override
  void start(BuildContext context, TInputOutput input) {
    if (super.outputTransformer != null) {
      super.onEnd!.call(super.outputTransformer!.call(input));

      return;
    }

    super.onEnd!.call(input);
  }
}
