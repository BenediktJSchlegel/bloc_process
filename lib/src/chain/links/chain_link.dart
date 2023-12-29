import 'package:flutter/cupertino.dart';

import '../../helper/input_output_typed.dart';

abstract class ChainLink<TInput, TOutput>
    with InputOutputTyped<TInput, TOutput> {
  @protected
  final dynamic Function(TOutput output)? transformer;

  void Function(dynamic output)? onEnd;

  ChainLink(this.transformer);

  void start(BuildContext context, TInput input);
}
