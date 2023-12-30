import 'package:flutter/cupertino.dart';

import '../../helper/input_output_typed.dart';

abstract class ChainLink<TInput, TOutput>
    with InputOutputTyped<TInput, TOutput> {
  final dynamic Function(TOutput output)? outputTransformer;

  final TInput Function(dynamic input)? inputTransformer;

  void Function(dynamic output)? onEnd;

  ChainLink({
    required this.outputTransformer,
    required this.inputTransformer,
  });

  void start(BuildContext context, TInput input);
}
