import 'package:flutter/cupertino.dart';

import '../../helper/input_output_typed.dart';

/// abstract base for links within a `ProcessChain`. See `BreakoutLink`, `PassLink`, `DecisionLink` and `ProcessLink`.
abstract class ChainLink<TInput, TOutput> with InputOutputTyped<TInput, TOutput> {
  final dynamic Function(TOutput output)? outputTransformer;

  final TInput Function(dynamic input)? inputTransformer;

  Future<void> Function(dynamic output)? onEnd;

  ChainLink({
    this.outputTransformer,
    this.inputTransformer,
  });

  void start(BuildContext context, TInput input);
}
