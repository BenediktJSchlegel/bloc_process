import 'package:bloc_process/src/chain/links/chain_link.dart';
import 'package:flutter/src/widgets/framework.dart';

class Breakout<TInput, TOutput> extends ChainLink<TInput, TOutput> {
  Breakout(super.transformer);

  @override
  void start(BuildContext context, TInput input) {
    // not needed
  }
}
