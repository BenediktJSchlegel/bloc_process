import 'package:flutter/widgets.dart';

import '../../../bloc_process.dart';

class PassLink<TInputOutput> extends ChainLink<TInputOutput, TInputOutput> {
  PassLink({
    required super.outputTransformer,
    required super.inputTransformer,
  });

  @override
  void start(BuildContext context, TInputOutput input) {
    if (super.outputTransformer != null) {
      super.onEnd!.call(super.outputTransformer!.call(input));
    }

    super.onEnd!.call(input);
  }
}
